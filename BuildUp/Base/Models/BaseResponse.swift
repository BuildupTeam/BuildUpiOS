//
//  BaseResponse.swift
//  flyers
//
//  Created by Mahmoud Nasser on 27/09/2022.
//

import Foundation
import ObjectMapper
import Moya

class BaseResponse: Mappable {
    
    var message: String?
    var errors: [String: String]?
    var statusCode: Int?
    var code: Int?
    var meta: MetaModel?
    var moyaError: MoyaError?
    
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
    
    required init?(map: Map) {
    }
        
    func mapping(map: Map) {
        message <- map["error"]
        message <- map["message"]
        errors <- map["errors"]
        statusCode <- map["statusCode"]
        code <- map["code"]
        meta <- map["pagination"]
    }
}
