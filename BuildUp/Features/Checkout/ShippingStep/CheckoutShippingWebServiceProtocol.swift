//
//  CheckoutShippingWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol CheckoutShippingWebServiceProtocol: AnyObject {
    func getAddresses(compeltion: @escaping ((Result<AddressesResponseModel, NetworkError>) -> Void))
}

class CheckoutShippingWebService: CheckoutShippingWebServiceProtocol {
    
    static let shared = CheckoutShippingWebService()
    
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
}