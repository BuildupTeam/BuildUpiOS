//
//  CheckoutReviewWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol CheckoutReviewWebServiceProtocol: AnyObject {
    func getSummary(addressId: Int, compeltion: @escaping ((Result<SummaryResponseModel, NetworkError>) -> Void))
}

class CheckoutReviewWebService: CheckoutReviewWebServiceProtocol {
    
    static let shared = CheckoutReviewWebService()
    
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
}
