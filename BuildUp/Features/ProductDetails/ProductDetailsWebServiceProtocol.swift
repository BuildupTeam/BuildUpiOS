//
//  ProductDetailsWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol ProductDetailsWebServiceProtocol: AnyObject {
    func getProductDetails(uuid: String, compeltion: @escaping ((Result<ProductDetailsResponseModel, NetworkError>) -> Void))
    func getRelatedProducts(limit: Int, compeltion: @escaping ((Result<RelatedProductsResponseModel, NetworkError>) -> Void))
}

class ProductDetailsWebService: BaseWebService, ProductDetailsWebServiceProtocol {
    
    static let shared = ProductDetailsWebService()
    
    func getProductDetails(uuid: String, compeltion: @escaping ((Result<ProductDetailsResponseModel, NetworkError>) -> Void)) {
        
        MainWebService.fetch(
            endPoint: RouteProductDetailsApi.getProductDetails(uuid: uuid)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let productDetailsResponse = Mapper<ProductDetailsResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    productDetailsResponse.statusCode = statusCode
                    compeltion(Result.success(productDetailsResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
    
    func getRelatedProducts(limit: Int, compeltion: @escaping ((Result<RelatedProductsResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteProductDetailsApi.getRelatedProducts(limit: limit)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let relatedProductsResponse = Mapper<RelatedProductsResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    relatedProductsResponse.statusCode = statusCode
                    compeltion(Result.success(relatedProductsResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
}
