//
//  RouteDefaultAddressApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/12/2023.
//

import Foundation
import Moya

enum RouteDefaultAddressApi {
    case setDefaultAddress(addressId: Int)
}

extension RouteDefaultAddressApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .setDefaultAddress(addressId: let id):
            return ApiUrls.Apis.setDefaultUrl.replacingOccurrences(of: "{id}", with: String(id))
        }
    }
    
    var method: Moya.Method {
        return .put
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
