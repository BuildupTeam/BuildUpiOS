//
//  RouteLogoutApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 07/11/2023.
//

import Foundation
import Foundation
import Moya

enum RouteLogoutApi {
    case logoutUser(token: String)
}

extension RouteLogoutApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.logoutUrl
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .logoutUser(token: let token):
            
            var parameters: [String: Any] = [:]
            parameters["token"] = token

            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
}
