//
//  RouteOrdersApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/11/2023.
//

import Foundation
import Moya

enum RouteOrdersApi {
    case getOrders(completed: Int)
}

extension RouteOrdersApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.ordersUrl
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getOrders(completed: let completed):
            let parameters: [String: Any] = ["completed": completed]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
