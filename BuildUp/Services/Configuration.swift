//
//  Configuration.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import UIKit

// test
enum Environment: String {
    case stage
    case live
    case preLive
    case demo
    
    var baseURL: String {
        //        let url = "https://online-shop.ecommerce.buildupp.co"
        //        return url + "/ec/api/v1/f"
        //        /*
        let subDomain = CachingService.getSubdomain()
        
        switch self {
        case .stage: return "https://online-shop.ecommerce.buildupp.co/"
        case .live: return "https://\(subDomain).ecommerce.buildupp.co/ec/api/v1/f"
        case .demo: return "https://\(subDomain).ecommerce-demo.buildupp.co/api/v1/f"
        case .preLive: return "https://\(subDomain).ecommerce.buildupp.co/ec/api/v1/f"
        }
        
        /*
         switch self {
         case .stage:
             return "https://\(subDomain).bk.ecommerce-clients.buildupp.co/ec/api/v1/f"
         case .live:
             return "https://\(subDomain).bk.ecommerce-clients.buildupp.co/ec/api/v1/f"
         case .demo:
             return "https://\(subDomain).bk.ecommerce-clients.buildupp.co/ec/api/v1/f"
         case .preLive:
             return "https://\(subDomain).bk.ecommerce-clients.buildupp.co/ec/api/v1/f"
         }
         */
    }
    
    var hostURL: String {
        let subDomain = CachingService.getSubdomain()

        switch self {
        case .stage: return "https://online-shop.ecommerce.buildupp.co/"
        case .live: return "https://\(subDomain).ecommerce.buildupp.co/ec/api/v1/f"
        case .demo: return "https://\(subDomain).ecommerce-demo.buildupp.co/ec/api/v1/f"
        case .preLive: return "https://\(subDomain).ecommerce.buildupp.co/ec/api/v1/f"
            
        }
    }
    
    var googleServiceInfo: String {
        switch self {
        case .stage: return "GoogleService-Info"
        case .live: return "GoogleService-Info"
        case .demo: return "GoogleService-Info"
        case .preLive: return "GoogleService-Info"
        }
    }
    
    var xApiKey: String {
        switch self {
        case .stage: return ""
        case .live: return ""
        case .demo: return ""
        case .preLive: return ""
        }
    }
}

struct Configuration {
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            
            switch configuration {
            case Environment.stage.rawValue:
                return Environment.stage
            case Environment.live.rawValue:
                return Environment.live
            case Environment.demo.rawValue:
                return Environment.demo
            case Environment.preLive.rawValue:
                return Environment.preLive
            default:
                return Environment.live
            }
        }
        return Environment.live
    }()
}
