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
    case adminStage
    case adminLive
    
    var baseURL: String {
        switch self {
        case .stage: return "https://my-app-3.backend.buildupp.co"
        case .live: return "https://my-app-3.backend.buildupp.co"
        case .adminStage: return "https://my-app-3.backend.buildupp.co"
        case .adminLive: return "https://my-app-3.backend.buildupp.co"
        }
    }
    
    var hostURL: String {
        switch self {
        case .stage: return "https://my-app-3.backend.buildupp.co"
        case .live: return "https://my-app-3.backend.buildupp.co"
        case .adminStage: return "https://my-app-3.backend.buildupp.co"
        case .adminLive: return "https://my-app-3.backend.buildupp.co"
        }
    }
    
    var googleServiceInfo: String {
        switch self {
        case .stage: return "GoogleService-Info"
        case .live: return "GoogleService-Info"
        case .adminStage: return ""
        case .adminLive: return "GoogleService-Info"
        }
    }
    
    var xApiKey: String {
        switch self {
        case .stage: return ""
        case .live: return ""
        case .adminStage: return ""
        case .adminLive: return ""
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
            case Environment.adminStage.rawValue:
                return Environment.adminStage
            case Environment.adminLive.rawValue:
                return Environment.adminLive
            default:
                return Environment.live
            }
        }
        return Environment.live
    }()
}
