//
//  CheckoutPaymentWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol CheckoutPaymentWebServiceProtocol: AnyObject {
    func getPaymentMethods(countryCode: String, compeltion: @escaping ((Result<PaymentMethodsResponseModel, NetworkError>) -> Void))
}

class CheckoutPaymentWebService: CheckoutPaymentWebServiceProtocol {
    
    static let shared = CheckoutPaymentWebService()
    
    func getPaymentMethods(countryCode: String, compeltion: @escaping ((Result<PaymentMethodsResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteCheckoutPaymentApi.getPaymentMethods(countryCode: countryCode)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let paymentMethodsResponse = Mapper<PaymentMethodsResponseModel>().map(JSONObject: response) else {
                    return
                }
                paymentMethodsResponse.statusCode = statusCode
                compeltion(Result.success(paymentMethodsResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
}
