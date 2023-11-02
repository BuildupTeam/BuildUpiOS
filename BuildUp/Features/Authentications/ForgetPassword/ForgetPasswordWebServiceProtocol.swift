//
//  ForgetPasswordWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/11/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol ForgetPasswordWebServiceProtocol: AnyObject {
    func forgetPassword(email: String,
                        compeltion: @escaping ((Result<ForgetPasswordResponseModel, NetworkError>) -> Void))
}

class ForgetPasswordWebService: BaseWebService, ForgetPasswordWebServiceProtocol {
    
    static let shared = ForgetPasswordWebService()
    
    func forgetPassword(email: String,
                        compeltion: @escaping ((Result<ForgetPasswordResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteForgetPasswordApi.forgetPassword(email: email)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let productsResponse = Mapper<ForgetPasswordResponseModel>().map(JSONObject: response) else {
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
