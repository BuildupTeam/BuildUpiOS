//
//  CitiesWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol CitiesWebServiceProtocol: AnyObject {
    func getCities(countryId: Int, compeltion: @escaping ((Result<CitiesResponseModel, NetworkError>) -> Void))
}

class CitiesWebService: CitiesWebServiceProtocol {
    
    static let shared = CitiesWebService()
    
    func getCities(countryId: Int, compeltion: @escaping ((Result<CitiesResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteCitiesApi.getCities(countryId: countryId)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let searchResponse = Mapper<CitiesResponseModel>().map(JSONObject: response) else {
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
