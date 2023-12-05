//
//  OrderDetailsWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol OrderDetailsWebServiceProtocol: AnyObject {
    func getOrderDetails(orderId: String, compeltion: @escaping ((Result<OrderDetailsResponseModel, NetworkError>) -> Void))
}

class OrderDetailsWebService: OrderDetailsWebServiceProtocol {
    
    static let shared = OrderDetailsWebService()
    
    func getOrderDetails(orderId: String, compeltion: @escaping ((Result<OrderDetailsResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteOrderDetialsApi.getOrderDetails(orderId: orderId)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let orderDetailsResponse = Mapper<OrderDetailsResponseModel>().map(JSONObject: response) else {
                    return
                }
                orderDetailsResponse.statusCode = statusCode
                compeltion(Result.success(orderDetailsResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
}
