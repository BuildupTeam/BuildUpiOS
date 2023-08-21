//
//  RouteHomeProductsApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/08/2023.
//

import Foundation
import Moya

enum RouteHomeProductsApi {
    case getHomeProducts(limit: Int,
                         componentModel: ComponentConfigurationModel)
}

extension RouteHomeProductsApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
        
    }
    
    var path: String {
        return ApiUrls.Apis.homeProducts
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getHomeProducts(limit: let limit, componentModel: let model):
            var parameters: [String: Any] = ["limit": limit]
            
            if let sortBy = model.orderBy {
                parameters["sort[by]"] = sortBy
            }
            if let sortDir = model.orderDir {
                parameters["sort[dir]"] = sortDir
            }
            if let categories = model.categories {
                if let category = categories.first {
                    parameters["categories_ids[0]"] = category.id
                }
            }
            if let discount = model.filters?.discount {
                parameters["discount"] = discount
            }
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        
        //https://my-app-3.backend.buildupapp.co/api/v1/ec/f/products?limit=10&sort[by]=id&sort[dir]=desc&categories_ids[0]=1&discount=&discount_range[from]=null&discount_range[to]=&has_discount='
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}

