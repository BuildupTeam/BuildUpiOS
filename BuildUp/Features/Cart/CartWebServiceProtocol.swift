//
//  CartWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol CartWebServiceProtocol: AnyObject {
    func getCart(compeltion: @escaping ((Result<CartResponseModel, NetworkError>) -> Void))
}

class CartWebService: CartWebServiceProtocol {
    
    static let shared = CartWebService()
    
    func getCart(compeltion: @escaping ((Result<CartResponseModel, NetworkError>) -> Void)) {
        
        MainWebService.fetch(endPoint: RouteCartApis.getCart) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let searchResponse = Mapper<CartResponseModel>().map(JSONObject: response) else {
                    return
                }
                searchResponse.statusCode = statusCode
                compeltion(Result.success(searchResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
}
