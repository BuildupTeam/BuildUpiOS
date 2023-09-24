//
//  RouteProductListApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import Foundation
import Moya

enum RouteProductListApi {
    case getProductList(perPage: Int,
                        page: Int? = nil,
                        componentModel: ComponentConfigurationModel)
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
                             componentModel: let model):
            var parameters: [String: Any] = ["per_page": perPage]
            
            if let page = page {
                parameters["page"] = page
            }
            
            if let sortBy = model.orderBy {
                parameters["sort[by]"] = sortBy
            }
            if let sortDir = model.orderDir {
                parameters["sort[dir]"] = sortDir
            }
            if let categories = model.categories {
                if let categoryId = categories.first {
                    parameters["categories_ids[0]"] = categoryId
                }
            }
            if let discount = model.filters?.discount {
                parameters["discount"] = discount
            }
            
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        
        //https://my-app-3.backend.buildupapp.co/api/v1/ec/f/products?limit=10&sort[by]=id&sort[dir]=desc&categories_ids[0]=1&discount=&discount_range[from]=null&discount_range[to]=&has_discount='
        
        //curl --location -g 'https://my-app-3.backend.buildupapp.co/api/v1/ec/f/products?sort[by]=price&sort[dir]=desc&categories_ids[0]=1&discount=&discount_range[from]=null&discount_range[to]=&has_discount=&cursor_by=id&cursor_dir=desc&cursor_meta=1&per_page=5&cursor='
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
