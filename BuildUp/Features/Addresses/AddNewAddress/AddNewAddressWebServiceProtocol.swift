//
//  AddNewAddressWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol AddNewAddressWebServiceProtocol: AnyObject {
    func addNewAddress(countryId: Int, cityId: Int, areaId: Int, address: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void))
    func updateAddress(addressId: Int, countryId: Int, cityId: Int, areaId: Int, address: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void))
}

class AddNewAddressWebService: AddNewAddressWebServiceProtocol {
    
    static let shared = AddNewAddressWebService()
    
    func addNewAddress(countryId: Int, cityId: Int, areaId: Int, address: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteAddNewAddressApi.addNewAddress(countryId: countryId, cityId: cityId, areaId: areaId, description: address)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let baseResponse = Mapper<BaseResponse>().map(JSONObject: response) else {
                    return
                }
                baseResponse.statusCode = statusCode
                compeltion(Result.success(baseResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
    
    func updateAddress(addressId: Int, countryId: Int, cityId: Int, areaId: Int, address: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteAddNewAddressApi.updateAddress(addressId: addressId, countryId: countryId, cityId: cityId, areaId: areaId, description: address)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let baseResponse = Mapper<BaseResponse>().map(JSONObject: response) else {
                    return
                }
                baseResponse.statusCode = statusCode
                compeltion(Result.success(baseResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
}
