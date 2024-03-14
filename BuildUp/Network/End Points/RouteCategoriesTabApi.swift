//
//  RouteCategoriesTabApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/11/2023.
//

import Foundation
import Moya

enum RouteCategoriesTabApi {
    case getCategories(limit: Int)
    case getProductList(perPage: Int,
                        page: Int?,
                        cursor: String?,
                        categoryModel: CategoryModel)
}

extension RouteCategoriesTabApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return ApiUrls.Apis.homeCategories
        case .getProductList:
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
        case .getCategories(limit: let limit):
            var parameters: [String: Any] = [:]
            parameters["sort[by]"] = "id"
            parameters["sort[dir]"] = "desc"
            parameters["subcategory"] = "0"
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getProductList(perPage: let perPage, page: let page, cursor: let cursor, categoryModel: let model):
            var parameters: [String: Any] = ["per_page": perPage]
            parameters["page"] = page
            parameters["categories_ids[0]"] = model.id
            parameters["sort[by]"] = "id"
            parameters["sort[dir]"] = "desc"
            
            parameters["cursor"] = cursor
            parameters["cursor_meta"] = "1"
            parameters["cursor_by"] = "id"
            parameters["cursor_dir"] = "desc"
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
