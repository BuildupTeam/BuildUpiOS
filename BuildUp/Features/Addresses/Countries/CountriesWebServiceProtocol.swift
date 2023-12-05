//
//  CountriesWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol CountriesWebServiceProtocol: AnyObject {
    func getCountries(compeltion: @escaping ((Result<CountriesResponseModel, NetworkError>) -> Void))
}

class CountriesWebService: CountriesWebServiceProtocol {
    
    static let shared = CountriesWebService()
    
    func getCountries(compeltion: @escaping ((Result<CountriesResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteCountriesApi.getCountries) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let searchResponse = Mapper<CountriesResponseModel>().map(JSONObject: response) else {
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
