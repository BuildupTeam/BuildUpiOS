//
//  RouteResetPasswordApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 31/10/2023.
//

import Foundation
import Moya

enum RouteResetPasswordApi {
    case resetPassword(email: String, password: String, code: String)
}

extension RouteResetPasswordApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.resetPasswordUrl
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .resetPassword(email: let email, password: let password, code: let code):
            
            var parameters: [String: Any] = [:]
            parameters["email"] = email
            parameters["password"] = password
            parameters["password_confirmation"] = password
            parameters["token"] = code // 1000 //CachingService.getUser()?.accessToken
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
