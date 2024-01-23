//
//  RouteProductListApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import Foundation
import Moya

enum RouteProductListApi {
    case getComponentProductList(perPage: Int,
                                 page: Int? = nil,
                                 cursor: String? = nil,
                                 componentModel: ComponentConfigurationModel)
    
    case getProductList(perPage: Int,
                        page: Int? = nil,
                        cursor: String? = nil,
                        productModel: ProductModel)
}

extension RouteProductListApi: TargetType {
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
        case .getProductList(perPage: let perPage,
                             page: let page,
                             cursor: let cursor,
                             productModel: let model):
            var parameters: [String: Any] = ["per_page": perPage]
            parameters["sort[by]"] = "id"
            parameters["sort[dir]"] = "desc"
            
            parameters["cursor"] = cursor
            parameters["cursor_meta"] = "1"
            parameters["cursor_by"] = "id"
            parameters["cursor_dir"] = "desc"
            
            //            if let page = page {
            //                parameters["page"] = page
            //            }
            
            if let subcategories = model.subcategories, !subcategories.isEmpty {
                let subcategoriesIDs = model.subcategories?.map({$0.id})
                parameters["categories_ids"] = subcategoriesIDs
            } else {
                if let categories = model.categories, !categories.isEmpty {
                    let categoriesIDs = model.categories?.map({$0.id})
                    parameters["categories_ids"] = categoriesIDs
                }
            }
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .getComponentProductList(perPage: let perPage,
                                      page: let page,
                                      cursor: let cursor,
                                      componentModel: let model):
            var parameters: [String: Any] = ["per_page": perPage]
            parameters["sort[by]"] = "id"
            parameters["sort[dir]"] = "desc"
            
            parameters["cursor"] = cursor
            parameters["cursor_meta"] = "1"
            parameters["cursor_by"] = "id"
            parameters["cursor_dir"] = "desc"
            
            if let subcategories = model.subcategories, !subcategories.isEmpty {
                parameters["categories_ids"] = subcategories
            } else {
                if let categories = model.categories, !categories.isEmpty {
                    parameters["categories_ids"] = categories
                }
            }
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
