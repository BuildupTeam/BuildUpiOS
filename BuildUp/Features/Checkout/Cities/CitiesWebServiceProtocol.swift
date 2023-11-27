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
                guard let citiesResponse = Mapper<CitiesResponseModel>().map(JSONObject: response) else {
                    return
                }
                citiesResponse.statusCode = statusCode
                compeltion(Result.success(citiesResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
}
