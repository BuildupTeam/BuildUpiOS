//
//  RouteCheckoutPaymentApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/01/2024.
//

import Foundation
import Moya

enum RouteCheckoutPaymentApi {
    case getPaymentMethods(countryCode: String)
}

extension RouteCheckoutPaymentApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.paymentMethodsUrl
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPaymentMethods(countryCode: let countryCode):
            let parameters: [String: Any] = ["country_code": countryCode]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
