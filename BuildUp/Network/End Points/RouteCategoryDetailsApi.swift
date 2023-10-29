//
//  RouteCategoryDetailsApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/09/2023.
//

import Foundation
import Moya

enum RouteCategoryDetailsApi {
    case getSubcategories(parentId: Int)
    case getProductsList(categoryId: Int,
                         perPage: Int,
                         page: Int? = nil,
                         componentModel: ComponentConfigurationModel)
}

extension RouteCategoryDetailsApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
        
    }
    
    var path: String {
        switch self {
        case .getSubcategories:
            return ApiUrls.Apis.homeCategories
        case .getProductsList:
            return ApiUrls.Apis.homeProducts
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
        case .getSubcategories(parentId: let parentId):
            let parameters: [String: Any] = ["parents_ids[0]": parentId]
//            if let sortBy = model.orderBy {
//                parameters["sort[by]"] = sortBy
//            }
//            if let sortDir = model.orderDir {
//                parameters["sort[dir]"] = sortDir
//            }
//            if let discount = model.filters?.discount {
//                parameters["discount"] = discount
//            }
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .getProductsList(categoryId: let categoryId,
                             perPage: let perPage,
                             page: let page,
                             componentModel: let model):
            var parameters: [String: Any] = ["per_page": perPage]
            
            parameters["categories_ids[0]"] = categoryId
            parameters["sort[by]"] = "id"
            parameters["sort[dir]"] = "desc"

            if let page = page {
                parameters["page"] = page
            }
//            
//            if let sortBy = model.orderBy {
//                parameters["sort[by]"] = sortBy
//            }
//            
//            if let sortDir = model.orderDir {
//                parameters["sort[dir]"] = sortDir
//            }
//            
//            
//            if let discount = model.filters?.discount {
//                parameters["discount"] = discount
//            }
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        }
        
        
        //https://my-app-3.backend.buildupapp.co/api/v1/ec/f/categories?limit=10&sort[by]=id&sort[dir]=desc&is_main=1&parents_ids[0]=1&ids[0]=1
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
