//
//  ProfileWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 07/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol ProfileWebServiceProtocol: AnyObject {
    func logoutUser(token: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void))
}

class ProfileWebService: ProfileWebServiceProtocol {
    
    static let shared = ProfileWebService()
    
    func logoutUser(token: String, compeltion: @escaping ((Result<BaseResponse, NetworkError>) -> Void)) {
        
        MainWebService.fetch(endPoint: RouteLogoutApi.logoutUser(token: token)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let searchResponse = Mapper<BaseResponse>().map(JSONObject: response) else {
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
