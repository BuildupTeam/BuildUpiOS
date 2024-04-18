//
//  CheckoutWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 03/04/2024.
//

import Foundation
import ObjectMapper
import Moya

protocol CheckoutWebServiceProtocol: AnyObject {
    func getAddresses(compeltion: @escaping ((Result<AddressesResponseModel, NetworkError>) -> Void))
    func getPaymentMethods(countryCode: String, compeltion: @escaping ((Result<PaymentMethodsResponseModel, NetworkError>) -> Void))
    func getSummary(addressId: Int, compeltion: @escaping ((Result<SummaryResponseModel, NetworkError>) -> Void))
    func checkout(checkoutModel: CheckoutModel, compeltion: @escaping ((Result<CheckoutResponseModel, NetworkError>) -> Void))
    func paymentCancelled(orderUUID: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void))
    func completeOrder(transactionId: String, orderUUID: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void))
}

class CheckoutWebService: CheckoutWebServiceProtocol {
    
    static let shared = CheckoutWebService()
    
    func getAddresses(compeltion: @escaping ((Result<AddressesResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteAddressesApi.getAddresses) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let addressesResponse = Mapper<AddressesResponseModel>().map(JSONObject: response) else {
                    return
                }
                addressesResponse.statusCode = statusCode
                compeltion(Result.success(addressesResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
    
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
    
    func getSummary(addressId: Int, compeltion: @escaping ((Result<SummaryResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteCheckoutReviewApi.getSummary(addressId: addressId)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let summaryResponse = Mapper<SummaryResponseModel>().map(JSONObject: response) else {
                    return
                }
                summaryResponse.statusCode = statusCode
                compeltion(Result.success(summaryResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
    
    func checkout(checkoutModel: CheckoutModel, compeltion: @escaping ((Result<CheckoutResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteCheckoutReviewApi.checkout(checkoutModel: checkoutModel)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let checkoutResponse = Mapper<CheckoutResponseModel>().map(JSONObject: response) else {
                    return
                }
                checkoutResponse.statusCode = statusCode
                compeltion(Result.success(checkoutResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
    
    func paymentCancelled(orderUUID: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteCheckoutReviewApi.paymentCanceled(orderUUID: orderUUID)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let checkoutResponse = Mapper<BaseResponse>().map(JSONObject: response) else {
                    return
                }
                checkoutResponse.statusCode = statusCode
                compeltion(Result.success(checkoutResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
    
    func completeOrder(transactionId: String ,orderUUID: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteCheckoutReviewApi.completeOrder(orderUUID: orderUUID, transactionId: transactionId)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let checkoutResponse = Mapper<BaseResponse>().map(JSONObject: response) else {
                    return
                }
                checkoutResponse.statusCode = statusCode
                compeltion(Result.success(checkoutResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
}
