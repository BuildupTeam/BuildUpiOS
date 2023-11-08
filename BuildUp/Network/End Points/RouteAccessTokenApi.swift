//
//  RouteAccessTokenApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/11/2023.
//

import Foundation
import Moya

enum RouteAccessTokenApi {
    case getAccessToken(refreshToken: String)
}

extension RouteAccessTokenApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getAccessToken:
            return ApiUrls.Apis.getAccessToken
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAccessToken:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .getAccessToken(refreshToken: let refreshToken):
            
            var parameters: [String: Any] = [:]
            parameters["refresh_token"] = refreshToken

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
}
