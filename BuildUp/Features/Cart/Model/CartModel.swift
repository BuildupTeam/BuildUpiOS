//
//  CartModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/09/2023.
//

import Foundation
import ObjectMapper

class CartModel: Mappable {
    
    var id: Int?
    var cartItems: [CartItemModel]?
    
    func mapping(map: Map) {
        id <- map["id"]
        cartItems <- map["cartItems"]
    }
    
    required init?(map: Map) {

    }
}
