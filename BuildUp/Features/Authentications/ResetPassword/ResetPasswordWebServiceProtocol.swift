//
//  ResetPasswordWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/11/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol ResetPasswordWebServiceProtocol: AnyObject {
    func resetPassword(email: String,
                        password: String,
                        compeltion: @escaping ((Result<ResetPasswordResponseModel, NetworkError>) -> Void))
}

class ResetPasswordWebService: BaseWebService, ResetPasswordWebServiceProtocol {
    
    static let shared = ResetPasswordWebService()
    
    func resetPassword(email: String,
                        password: String,
                        compeltion: @escaping ((Result<ResetPasswordResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteResetPasswordApi.resetPassword(email: email, password: password)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let productsResponse = Mapper<ResetPasswordResponseModel>().map(JSONObject: response) else {
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
