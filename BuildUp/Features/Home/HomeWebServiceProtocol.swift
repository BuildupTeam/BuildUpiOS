//
//  HomeWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol HomeWebServiceProtocol: AnyObject {
    func getHomeTemplate(compeltion: @escaping ((Result<UIConfirgurationResponseModel, NetworkError>) -> Void))
    func getHomeProducts(limit: Int,
                         componentModel: ComponentConfigurationModel,
                         compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void))
    func getHomeCategories(limit: Int,
                           componentModel: ComponentConfigurationModel,
                           compeltion: @escaping ((Result<CategoriesResponseModel, NetworkError>) -> Void))
    
    //api/v1/ec/f/categories?limit=10&sort[by]=id&sort[dir]=desc&ids[0]=1'
    //curl --location -g 'https://my-app-3.backend.buildupapp.co/api/v1/ec/f/products?limit=10&sort[by]=id&sort[dir]=desc&categories_ids[0]=1&discount=&discount_range[from]=null&discount_range[to]=&has_discount='
}

class HomeWebService: BaseWebService, HomeWebServiceProtocol {
    
    static let shared = HomeWebService()
   
    func getHomeTemplate(compeltion: @escaping ((Result<UIConfirgurationResponseModel, NetworkError>) -> Void)) {
        
        MainWebService.fetch(
            endPoint: RouteConfigurationApi.getConfiguration) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let homeResponse = Mapper<UIConfirgurationResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    homeResponse.statusCode = statusCode
                    compeltion(Result.success(homeResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
    
    func getHomeProducts(limit: Int,
                         componentModel: ComponentConfigurationModel,
                         compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteHomeProductsApi.getHomeProducts(limit: limit, componentModel: componentModel)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let homeProductsResponse = Mapper<ProductsResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    homeProductsResponse.statusCode = statusCode
                    compeltion(Result.success(homeProductsResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
    
    func getHomeCategories(limit: Int,
                           componentModel: ComponentConfigurationModel,
                           compeltion: @escaping ((Result<CategoriesResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteHomeCategoriesApi.getHomeCategories(limit: limit, componentModel: componentModel)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let homeCategoriesResponse = Mapper<CategoriesResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    homeCategoriesResponse.statusCode = statusCode
                    compeltion(Result.success(homeCategoriesResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
    
}
