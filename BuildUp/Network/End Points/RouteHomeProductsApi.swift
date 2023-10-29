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
            var categroiesSubcategoriesIDS: [Int] = []
            var parameters: [String: Any] = ["limit": limit]
            
            if let sortBy = model.orderBy {
                parameters["sort[by]"] = sortBy
            } else {
                parameters["sort[by]"] = "id"
            }
            
            if let sortDir = model.orderDir {
                parameters["sort[dir]"] = sortDir
            } else {
                parameters["sort[dir]"] = "desc"
            }
            
            if let discount = model.filters?.discount {
                parameters["discount_range[from]"] = "0"
                parameters["discount_range[to]"] = discount
            }
            
            
            if let subcategories = model.subcategories, !subcategories.isEmpty {
                categroiesSubcategoriesIDS.append(contentsOf: subcategories)
            } else {
                if let categories = model.categories, !categories.isEmpty {
                    categroiesSubcategoriesIDS.append(contentsOf: categories)
                }
            }
            
            if !categroiesSubcategoriesIDS.isEmpty {
                parameters["categories_ids"] = categroiesSubcategoriesIDS
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

