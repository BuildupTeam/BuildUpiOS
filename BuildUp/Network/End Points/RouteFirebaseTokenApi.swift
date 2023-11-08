//
//  RouteFirebaseTokenApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 07/11/2023.
//

import Foundation
import Moya

enum RouteFirebaseTokenApi {
    case getFirebaseToken(token: String)
}

extension RouteFirebaseTokenApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.fetchFirebaseToken
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getFirebaseToken(token: let token):
            
            var parameters: [String: Any] = [:]
            parameters["token"] = token

            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
}
