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
    func getCountries(compeltion: @escaping ((Result<CountriesResponseModel, NetworkError>) -> Void))
}

class CheckoutReviewWebService: CheckoutReviewWebServiceProtocol {
    
    static let shared = CheckoutReviewWebService()
    
    func getCountries(compeltion: @escaping ((Result<CountriesResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteCountriesApi.getCountries) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let searchResponse = Mapper<CountriesResponseModel>().map(JSONObject: response) else {
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
