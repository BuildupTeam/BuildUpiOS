//
//  NetworkError.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import Moya

enum Type: String, Codable {
    case business
    case system
    case mapping
}
struct NetworkError: Codable, Error {
   
    var code: Int?
    var message: String?
    var type: Type?
    var statusCode: Int?
//    var userInfo: [String: Any] = [:]
    
    init () {
    }
    
    init(error: MoyaError) {
        self.code = error.errorCode
        self.message = error.errorDescription

        switch error {
        case .underlying(let error, _):
            self.type = .system
            print(error)
        default :
            self.type = .mapping
        }
    }
}

extension NetworkError {
    static let parseError: NetworkError = {
        var error = NetworkError()
        error.type = Type.mapping
        return error
    }()
}
