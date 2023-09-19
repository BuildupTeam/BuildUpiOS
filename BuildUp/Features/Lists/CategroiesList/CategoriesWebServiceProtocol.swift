//
//  CategoriesWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 18/09/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol CategoriesWebServiceProtocol: AnyObject {
    func getCategoriesList(perPage: Int,
                           page: Int?,
                           componentModel: ComponentConfigurationModel,
                        compeltion: @escaping ((Result<CategoriesResponseModel, NetworkError>) -> Void))
}

class CategoriesWebService: BaseWebService, CategoriesWebServiceProtocol {
    
    static let shared = CategoriesWebService()
    
    func getCategoriesList(perPage: Int,
                           page: Int?,
                           componentModel: ComponentConfigurationModel,
                           compeltion: @escaping ((Result<CategoriesResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteCategoriesListApi.getCategories(limit: perPage, componentModel: componentModel)) { (result, statusCode) in
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
}

