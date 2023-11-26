//
//  RouteAddNewAddressApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/11/2023.
//

import Foundation
import Moya

enum RouteAddNewAddressApi {
    case addNewAddress(countryId: Int, cityId: Int, description: String)
    case updateAddress(addressId: Int, countryId: Int, cityId: Int, description: String)
}

extension RouteAddNewAddressApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .addNewAddress:
            return ApiUrls.Apis.addressesUrl
        case .updateAddress(addressId: let id, countryId: _, cityId: _, description: _):
            return ApiUrls.Apis.updateAdressUrl.replacingOccurrences(of: "{id}", with: String(id))
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addNewAddress:
            return .post
        case .updateAddress:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .addNewAddress(countryId: let countryId, cityId: let cityId, description: let desc):
            var parameters: [String: Any] = [:]
            
            parameters["country_id"] = countryId
            parameters["city_id"] = cityId
            parameters["description"] = desc

            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        case .updateAddress(addressId: _, countryId: let countryId, cityId: let cityId, description: let desc):
            var parameters: [String: Any] = [:]
            
            parameters["country_id"] = countryId
            parameters["city_id"] = cityId
            parameters["description"] = desc

            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
