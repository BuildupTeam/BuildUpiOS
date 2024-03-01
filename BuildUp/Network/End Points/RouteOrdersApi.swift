//
//  RouteOrdersApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/11/2023.
//

import Foundation
import Moya

enum RouteOrdersApi {
    case getOrders(perPage: Int,
                   page: Int? = nil,
                   cursor: String? = nil,
                   completed: Int)
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
        case .getOrders(perPage: let perPage,
                        page: let page,
                        cursor: let cursor,
                        completed: let completed):
            
            var parameters: [String: Any] = ["current": completed]
            
            parameters["sort[by]"] = "id"
            parameters["sort[dir]"] = "desc"
            parameters["cursor"] = cursor
            parameters["cursor_meta"] = "1"
            parameters["cursor_by"] = "id"
            parameters["cursor_dir"] = "desc"
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
