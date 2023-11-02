//
//  RegisterWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol RegisterWebServiceProtocol: AnyObject {
    func registerNewUser(model :RegisterModel,
                        compeltion: @escaping ((Result<RegisterResponseModel, NetworkError>) -> Void))
}

class RegisterWebService: BaseWebService, RegisterWebServiceProtocol {
    
    static let shared = RegisterWebService()
    
    func registerNewUser(model :RegisterModel,
                        compeltion: @escaping ((Result<RegisterResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteRegisterApi.registerUser(registerModel: model)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let productsResponse = Mapper<RegisterResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    productsResponse.statusCode = statusCode
                    compeltion(Result.success(productsResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
}
