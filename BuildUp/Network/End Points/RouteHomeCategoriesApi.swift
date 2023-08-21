//
//  RouteHomeCategoriesApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/08/2023.
//

import Foundation
import Moya

enum RouteHomeCategoriesApi {
    case getHomeCategories(limit: Int,
                         componentModel: ComponentConfigurationModel)
}

extension RouteHomeCategoriesApi: TargetType {
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
        case .getHomeCategories(limit: let limit, componentModel: let model):
            var parameters: [String: Any] = ["limit": limit]
            
            if let sortBy = model.orderBy {
                parameters["sort[by]"] = sortBy
            }
            if let sortDir = model.orderDir {
                parameters["sort[dir]"] = sortDir
            }
            if let discount = model.filters?.discount {
                parameters["discount"] = discount
            }
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        
        //     //api/v1/ec/f/categories?limit=10&sort[by]=id&sort[dir]=desc&ids[0]=1'
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
