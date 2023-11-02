//
//  RouteRegisterApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation
import Moya

enum RouteRegisterApi {
    case registerUser(registerModel: RegisterModel)
}

extension RouteRegisterApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.registerUrl
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .registerUser(registerModel: let model):
            
            var parameters: [String: Any] = [:]
            
            parameters["full_name"] = model.name
            parameters["phone"] = model.phone
            parameters["country_code"] = model.countryCode
            parameters["password"] = model.password
            parameters["password_confirmation"] = model.password
            parameters["email"] = model.email

            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}

extension RouteRegisterApi: CachePolicyGettableType {
    var cachePolicy: URLRequest.CachePolicy? {
        return .reloadIgnoringLocalCacheData
    }
}
