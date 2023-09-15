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
    case loginUser(facebookId: String?, accessToken: String?)
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
        case .loginUser(
            facebookId: let facebookId,
            accessToken: let accessToken):
            
            var parameters: [String: Any] = [:]
            parameters["facebook_id"] = facebookId
            parameters["access_token"] = accessToken
            
            parameters["appsflyer_id"] = AppsFlyerLib.shared().getAppsFlyerUID()
            
            let advertisingIdentifier = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            if advertisingIdentifier != "00000000-0000-0000-0000-000000000000" {
                parameters["advertising_id"] = advertisingIdentifier
            }
            
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
