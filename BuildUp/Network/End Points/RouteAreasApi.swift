//
//  RouteAreasApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import Moya

enum RouteAreasApi {
    case getAreas(cityId: Int)
}

extension RouteAreasApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.areasUrl
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAreas(cityId: let id):
            let parameters: [String: Any] = ["city_id": id]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
