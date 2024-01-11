//
//  CategoriesTabWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/11/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol CategoriesTabWebServiceProtocol: AnyObject {
    func getCategories(limit: Int,
                       compeltion: @escaping ((Result<CategoriesResponseModel, NetworkError>) -> Void))
    func getProductList(perPage: Int,
                        page: Int?,
                        categoryModel: CategoryModel,
                        compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void))
}

class CategoriesTabWebService: BaseWebService, CategoriesTabWebServiceProtocol {
    
    static let shared = CategoriesTabWebService()
    
    func getCategories(limit: Int,
                       compeltion: @escaping ((Result<CategoriesResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteCategoriesTabApi.getCategories(limit: limit)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let categoriesResponse = Mapper<CategoriesResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    categoriesResponse.statusCode = statusCode
                    compeltion(Result.success(categoriesResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
    
    func getProductList(perPage: Int,
                        page: Int?,
                        categoryModel: CategoryModel,
                        compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteCategoriesTabApi.getProductList(perPage: perPage, page: page, categoryModel: categoryModel)) { (result, statusCode) in
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

