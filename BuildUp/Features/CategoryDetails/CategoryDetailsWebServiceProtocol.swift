//
//  CategoryDetailsWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/09/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol CategoryDetailsWebServiceProtocol: AnyObject {
    func getCategoryDetails(parentId: Int,
                            compeltion: @escaping ((Result<CategoriesResponseModel, NetworkError>) -> Void))
    func getProductList(categoryId: Int,
                        perPage: Int,
                        page: Int?,
                        cursor: String?,
                        componentModel: ComponentConfigurationModel,
                        compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void))
}

class CategoryDetailsWebService: BaseWebService, CategoryDetailsWebServiceProtocol {
    
    static let shared = CategoryDetailsWebService()
    
    func getCategoryDetails(parentId: Int,
                            compeltion: @escaping ((Result<CategoriesResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteCategoryDetailsApi.getSubcategories(parentId: parentId)) { (result, statusCode) in
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
    
    func getProductList(categoryId: Int,
                        perPage: Int,
                        page: Int?,
                        cursor: String?,
                        componentModel: ComponentConfigurationModel,
                        compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteCategoryDetailsApi.getProductsList(categoryId: categoryId, perPage: perPage, page: page, cursor: cursor, componentModel: componentModel)) { (result, statusCode) in
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

