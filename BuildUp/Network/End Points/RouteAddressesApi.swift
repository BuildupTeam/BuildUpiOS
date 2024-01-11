//
//  RouteAddressesApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/11/2023.
//

import Foundation
import Moya

enum RouteAddressesApi {
    case getAddresses
}

extension RouteAddressesApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.addressesUrl
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAddresses:
            /*
             var parameters: [String: Any] = [:]
             parameters["default"] = "1"

             return .requestParameters(parameters: parameters,
                                       encoding: URLEncoding.default)
             */
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
