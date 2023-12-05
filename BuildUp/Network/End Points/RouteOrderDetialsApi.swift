//
//  RouteOrderDetialsApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import Foundation
import Moya

enum RouteOrderDetialsApi {
    case getOrderDetails(orderId: String)
}

extension RouteOrderDetialsApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getOrderDetails(orderId: let orderId):
            return ApiUrls.Apis.orderDetailsUrl.replacingOccurrences(of: "{id}", with: orderId)
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getOrderDetails:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
