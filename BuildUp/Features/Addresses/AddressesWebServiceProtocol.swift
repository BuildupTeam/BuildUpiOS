//
//  AddressesWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol AddressesWebServiceProtocol: AnyObject {
    func getAddresses(compeltion: @escaping ((Result<AddressesResponseModel, NetworkError>) -> Void))
    func setDefaultAddress(addressId: Int, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void))
}

class AddressesWebService: AddressesWebServiceProtocol {
    
    static let shared = AddressesWebService()
    
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
    
    func setDefaultAddress(addressId: Int, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteDefaultAddressApi.setDefaultAddress(addressId: addressId)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let addressesResponse = Mapper<BaseResponse>().map(JSONObject: response) else {
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
