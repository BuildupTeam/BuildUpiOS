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
            var categroiesSubcategoriesIDS: [Int] = []

            if let sortBy = model.orderBy {
                parameters["sort[by]"] = sortBy
            } else {
                parameters["sort[by]"] = "id"
            }
            if let isMain = model.filters?.isMain, isMain == 1 {
                parameters["is_main"] = isMain
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
                parameters["ids"] = subcategories
            } else {
                parameters["subcategory"] = 0
            }
            
//            if let subcategories = model.subcategories, !subcategories.isEmpty {
//                categroiesSubcategoriesIDS.append(contentsOf: subcategories)
//            } else {
//                if let categories = model.categories, !categories.isEmpty {
//                    categroiesSubcategoriesIDS.append(contentsOf: categories)
//                }
//            }
//            
//            if !categroiesSubcategoriesIDS.isEmpty {
//                parameters["ids"] = categroiesSubcategoriesIDS
//            }
            
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
