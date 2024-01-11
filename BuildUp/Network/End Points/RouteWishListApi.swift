//
//  RouteWishListApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/12/2023.
//

import Foundation
import Moya

enum RouteWishListApi {
    case getWishList
}

extension RouteWishListApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        print("base url = \(configuration.environment.baseURL)")
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.wishListUrl
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getWishList:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
