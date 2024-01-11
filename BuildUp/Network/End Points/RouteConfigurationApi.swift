//
//  RouteConfigurationApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 08/08/2023.
//

import Foundation
import Moya

enum RouteConfigurationApi {
    case getConfiguration
}

extension RouteConfigurationApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
        
    }
    
    var path: String {
        return ApiUrls.Apis.configurationUrl
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getConfiguration:
            var parameters: [String: Any] = ["platform": 1]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}

