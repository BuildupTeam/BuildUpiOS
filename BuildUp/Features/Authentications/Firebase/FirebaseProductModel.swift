//
//  FirebaseProductModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 08/11/2023.
//

import Foundation
import ObjectMapper

class FirebaseProductModel: Mappable {
    
    var uuid: String?
    var quantity: Int?
    var combinationId: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        quantity <- map["quantity"]
        combinationId <- map["combinationId"]
    }
}
