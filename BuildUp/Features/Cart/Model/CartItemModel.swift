//
//  CartItemModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/09/2023.
//

import Foundation
import ObjectMapper

class CartItemModel: Mappable {
    
    var id: Int?
    var name: String?
    var images: [String]?
    var price: Int?
    var quantity: Int?

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        images <- map["images"]
        price <- map["price"]
        quantity <- map["quantity"]
    }
    
    required init?(map: Map) {

    }
}
