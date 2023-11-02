//
//  LoginWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol LoginWebServiceProtocol: AnyObject {
    func login(model: LoginModel,
               compeltion: @escaping ((Result<LoginResponseModel, NetworkError>) -> Void))
}

class LoginWebService: BaseWebService, LoginWebServiceProtocol {
    
    static let shared = LoginWebService()
    
    func login(model: LoginModel,
               compeltion: @escaping ((Result<LoginResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteLoginApi.loginUser(loginModel: model)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let productsResponse = Mapper<LoginResponseModel>().map(JSONObject: response) else {
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
