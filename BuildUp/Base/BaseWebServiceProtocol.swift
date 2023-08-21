//
//  BaseWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol BaseWebServiceProtocol: AnyObject {
//    func getUser(
//        compeltion: @escaping ((Result<CreateProfileResponseModel, NetworkError>) -> Void))
}

class BaseWebService: BaseWebServiceProtocol {
    
    static let baseShared = BaseWebService()
    
    /*
    func getUser(
        compeltion: @escaping ((Result<CreateProfileResponseModel, NetworkError>) -> Void)) {
        
        MainWebService.fetch(
            endPoint: RouteUserApi.getUser) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let mappedResponse = Mapper<CreateProfileResponseModel>().map(JSONObject: response) else {
                    return
                }
                mappedResponse.statusCode = statusCode
                compeltion(Result.success(mappedResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
    */
    
}
