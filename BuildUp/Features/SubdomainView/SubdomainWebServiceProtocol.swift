//
//  SubdomainWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation
import UIKit
import ObjectMapper

protocol SubdomainWebServiceProtocol: AnyObject {
    func getHomeTemplate(compeltion: @escaping ((Result<UIConfirgurationResponseModel, NetworkError>) -> Void))
}

class SubdomainWebService: BaseWebService, SubdomainWebServiceProtocol {
    
    static let shared = SubdomainWebService()
    
    func getHomeTemplate(compeltion: @escaping ((Result<UIConfirgurationResponseModel, NetworkError>) -> Void)) {
        
        MainWebService.fetch(
            endPoint: RouteConfigurationApi.getConfiguration) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let homeResponse = Mapper<UIConfirgurationResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    homeResponse.statusCode = statusCode
                    compeltion(Result.success(homeResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    compeltion(Result.failure(error))
                }
            }
    }
}
