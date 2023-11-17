//
//  RouteAccessTokenApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/11/2023.
//

import Foundation
import Moya

enum RouteAccessTokenApi {
    case refreshToken(refreshToken: String)
}

extension RouteAccessTokenApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.refreshTokenUrl
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .refreshToken(refreshToken: let refreshToken):
            var parameters: [String: Any] = [:]
            parameters["refresh_token"] = refreshToken

            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
