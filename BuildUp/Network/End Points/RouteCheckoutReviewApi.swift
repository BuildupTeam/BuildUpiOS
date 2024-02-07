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
    case paymentCanceled(orderUUID: String)
    case completeOrder(orderUUID: String, transactionId: String)
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
        case .paymentCanceled(orderUUID: let uuid):
            return ApiUrls.Apis.paymentCanceledUrl.replacingOccurrences(of: "{uuid}", with: uuid)
        case .completeOrder(orderUUID: let uuid, transactionId: _):
            return ApiUrls.Apis.completeOrderUrl.replacingOccurrences(of: "{uuid}", with: uuid)
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
            parameters["payment_method"] = model.paymentMethod?.identifier
            parameters["customer_name"] = model.name
            if model.paymentMethod?.identifier == "cod" {
                parameters["payment_gateway"] = "cod"
            } else {
                parameters["payment_gateway"] = model.paymentMethod?.gateway?.identifier
            }
            parameters["customer_country_code"] = model.countryCode
            parameters["customer_phone"] = model.phone

            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        case .paymentCanceled:
            return .requestPlain
        case .completeOrder(orderUUID: let uuid, transactionId: let transactionId):
            var parameters: [String: Any] = [:]
            parameters["transaction_id"] = transactionId
            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
