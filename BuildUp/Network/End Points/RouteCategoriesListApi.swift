//
//  RouteCategoriesListApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 18/09/2023.
//

import Foundation
import Moya

enum RouteCategoriesListApi {
    case getCategories(limit: Int,
                       componentModel: ComponentConfigurationModel)
}

extension RouteCategoriesListApi: TargetType {
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
        case .getCategories(limit: let limit, componentModel: let model):
            var parameters: [String: Any] = ["limit": limit]
            
            parameters["is_main"] = 1
            
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
        
        //https://my-app-3.backend.buildupapp.co/api/v1/ec/f/categories?limit=10&sort[by]=id&sort
        //[dir]=desc&ids[0]=1'
        //https://my-app-3.backend.buildupapp.co/api/v1/ec/f/categories?limit=10&sort[by]=id&sort[dir]=desc&is_main=1&parents_ids[0]=1&ids[0]=1
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
