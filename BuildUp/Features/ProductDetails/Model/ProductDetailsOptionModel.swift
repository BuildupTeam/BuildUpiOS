//
//  ProductDetailsOptionModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/09/2023.
//

import Foundation
import ObjectMapper

class ProductDetailsOptionModel: Mappable {
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
