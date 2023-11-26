//
//  RouteCheckoutReviewApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import Moya

enum RouteCheckoutReviewApi {
    case getCountries
}

extension RouteCheckoutReviewApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.countriesUrl
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCountries:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
