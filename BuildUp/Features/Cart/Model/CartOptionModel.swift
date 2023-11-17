//
//  CartOptionModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 13/11/2023.
//

import Foundation
import ObjectMapper

class CartOptionModel: Mappable {
    
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
