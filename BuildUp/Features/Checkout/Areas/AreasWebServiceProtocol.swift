//
//  AreasWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol AreasWebServiceProtocol: AnyObject {
    func getAreas(cityId: Int, compeltion: @escaping ((Result<AreasResponseModel, NetworkError>) -> Void))
}

class AreasWebService: AreasWebServiceProtocol {
    
    static let shared = AreasWebService()
    
    func getAreas(cityId: Int, compeltion: @escaping ((Result<AreasResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteAreasApi.getAreas(cityId: cityId)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let areasResponse = Mapper<AreasResponseModel>().map(JSONObject: response) else {
                    return
                }
                areasResponse.statusCode = statusCode
                compeltion(Result.success(areasResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
}
