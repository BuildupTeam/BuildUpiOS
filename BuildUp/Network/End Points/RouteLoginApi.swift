//
//  RouteLoginApi.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//
import Foundation
import Moya
import AppsFlyerLib
import AdSupport

// swiftlint:disable force_unwrapping

enum RouteLoginApi {
    case loginUser(loginModel: LoginModel)
}

extension RouteLoginApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.loginUrl
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .loginUser(loginModel: let model):
            
            var parameters: [String: Any] = [:]
            parameters["phone"] = model.phone
            parameters["country_code"] = model.countryCodeWithoutPlus
            parameters["password"] = model.password
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}

extension RouteLoginApi: CachePolicyGettableType {
    var cachePolicy: URLRequest.CachePolicy? {
        return .reloadIgnoringLocalCacheData
    }
}
