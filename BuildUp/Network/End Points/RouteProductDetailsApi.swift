//
//  RouteProductDetailsApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import Foundation
import Moya

enum RouteProductDetailsApi {
    case getProductDetails(uuid: String)
    case getRelatedProducts(limit: Int)
}

extension RouteProductDetailsApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getProductDetails(uuid: let uuid):
            return ApiUrls.Apis.productDetails.replacingOccurrences(of: "{id}", with: uuid)
        case .getRelatedProducts:
            return ApiUrls.Apis.relatedProducts
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
        case .getProductDetails:
            return .requestPlain
        case .getRelatedProducts(let limit):
            let parameters: [String: Any] = ["limit": limit]
            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
