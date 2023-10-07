//
//  RouteCartApis.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/09/2023.
//

import Foundation
import Moya

enum RouteCartApis {
    case getCart
}

extension RouteCartApis: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.homeCategories
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCart:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
