//
//  ProductListWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import Foundation
import UIKit
import ObjectMapper

import UIKit
import ObjectMapper

protocol ProductListWebServiceProtocol: AnyObject {
    func getProductList(perPage: Int,
                        page: Int?,
                        componentModel: ComponentConfigurationModel,
                        compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void))
}

class ProductListWebService: BaseWebService, ProductListWebServiceProtocol {
    
    static let shared = ProductListWebService()
    
    func getProductList(perPage: Int,
                        page: Int?,
                        componentModel: ComponentConfigurationModel,
                        compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteProductListApi.getProductList(perPage: perPage, page: page, componentModel: componentModel)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let productsResponse = Mapper<ProductsResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    productsResponse.statusCode = statusCode
                    compeltion(Result.success(productsResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
}

