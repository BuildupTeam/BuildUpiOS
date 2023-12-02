//
//  RouteCheckoutReviewApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import Moya

enum RouteCheckoutReviewApi {
    case getSummary(addressId: Int)
    case checkout(checkoutModel: CheckoutModel)
}

extension RouteCheckoutReviewApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getSummary:
            return ApiUrls.Apis.summartUrl
        case .checkout:
            return ApiUrls.Apis.checkoutUrl
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getSummary(addressId: let addressId):
            var parameters: [String: Any] = [:]
            parameters["address_id"] = addressId

            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        case .checkout(checkoutModel: let model):
            var parameters: [String: Any] = [:]
            parameters["address_id"] = model.address?.id
            parameters["payment_method"] = model.paymentMethod
            parameters["customer_name"] = model.name
            parameters["customer_country_code"] = model.countryCode
            parameters["customer_phone"] = model.phone

            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
