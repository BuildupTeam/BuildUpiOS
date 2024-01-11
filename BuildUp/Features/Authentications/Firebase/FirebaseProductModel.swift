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
    
    init(uuid: String? = nil, quantity: Int? = nil, combinationId: Int? = nil) {
        self.uuid = uuid
        self.quantity = quantity
        self.combinationId = combinationId
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        quantity <- map["quantity"]
        combinationId <- map["combinationId"]
    }
    
    var dict: [String: Any] {
        if let combinId = combinationId {
            return [String(combinId): quantity ?? 1]
        } else {
            return ["default": quantity ?? 1]
        }
    }
}
