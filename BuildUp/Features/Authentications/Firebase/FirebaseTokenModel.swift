//
//  FirebaseTokenModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 07/11/2023.
//

import Foundation
import ObjectMapper

class FirebaseDataTokenModel: Mappable {
    
    var token: FirebaseTokenModel?

    func mapping(map: Map) {
        token <- map["token"]
    }
    
    required init?(map: Map) {

    }
}

class FirebaseTokenModel: Mappable {
    
    var token: String?

    func mapping(map: Map) {
        token <- map["token"]
    }
    
    required init?(map: Map) {

    }
}
