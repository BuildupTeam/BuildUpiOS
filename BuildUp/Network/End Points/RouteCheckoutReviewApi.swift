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
}

extension RouteCheckoutReviewApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.summartUrl
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
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
