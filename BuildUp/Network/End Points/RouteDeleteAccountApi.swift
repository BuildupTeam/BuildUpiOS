//
//  RouteDeleteAccountApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/07/2024.
//

import Foundation
import Foundation
import Moya

enum RouteDeleteAccountApi {
    case deleteAccount
}

extension RouteDeleteAccountApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        return ApiUrls.Apis.deleteAccountUrl
    }
    
    var method: Moya.Method {
        return .delete
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .deleteAccount:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
