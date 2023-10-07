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
    
    var baseURL: String {
        switch self {
        case .stage: return "https://my-app-3.ecommerce.buildupp.co/ec/api/v1/f"
        case .live: return "https://my-app-3.ecommerce.buildupp.co/ec/api/v1/f"
        case .preLive: return "https://my-app-3.ecommerce.buildupp.co/ec/api/v1/f"
        }
    }
    
    var hostURL: String {
        switch self {
        case .stage: return "https://my-app-3.ecommerce.buildupp.co/ec/api/v1/f"
        case .live: return "https://my-app-3.ecommerce.buildupp.co/ec/api/v1/f"
        case .preLive: return "https://my-app-3.ecommerce.buildupp.co/ec/api/v1/f"
        }
    }
    
    var googleServiceInfo: String {
        switch self {
        case .stage: return "GoogleService-Info"
        case .live: return "GoogleService-Info"
        case .preLive: return "GoogleService-Info"
        }
    }
    
    var xApiKey: String {
        switch self {
        case .stage: return ""
        case .live: return ""
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
            case Environment.preLive.rawValue:
                return Environment.preLive
            default:
                return Environment.live
            }
        }
        return Environment.live
    }()
}
