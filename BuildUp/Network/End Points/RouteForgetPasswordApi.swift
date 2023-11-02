//
//  RouteForgetPasswordApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 31/10/2023.
//

import Foundation
import Moya

enum RouteForgetPasswordApi {
    case forgetPassword(email: String)
}

extension RouteForgetPasswordApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.forgetPasswordUrl
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .forgetPassword(email: let email):
            
            var parameters: [String: Any] = [:]
            parameters["email"] = email
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
