//
//  OrderHistoryWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol OrderHistoryWebServiceProtocol: AnyObject {
    func getOrders(completed: Int,
                   perPage: Int,
                   page: Int?,
                   cursor: String?,
                   compeltion: @escaping ((Result<OrdersResponseModel, NetworkError>) -> Void))
}

class OrderHistoryWebService: OrderHistoryWebServiceProtocol {
    
    static let shared = OrderHistoryWebService()
    
    func getOrders(completed: Int,
                   perPage: Int,
                   page: Int?,
                   cursor: String?,
                   compeltion: @escaping ((Result<OrdersResponseModel, NetworkError>) -> Void)) {
            MainWebService.fetch(endPoint: RouteOrdersApi.getOrders(perPage: perPage,
                                                                    page: page,
                                                                    cursor: cursor,
                                                                    completed: completed)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let ordersResponse = Mapper<OrdersResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    ordersResponse.statusCode = statusCode
                    compeltion(Result.success(ordersResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
        }
}
