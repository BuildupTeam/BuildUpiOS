//
//  WishListWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/12/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol WishListWebServiceProtocol: AnyObject {
    func getWishList(compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void))
}

class WishListWebService: WishListWebServiceProtocol {
    
    static let shared = WishListWebService()
    
    func getWishList(compeltion: @escaping ((Result<ProductsResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteWishListApi.getWishList) { (result, statusCode) in
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
