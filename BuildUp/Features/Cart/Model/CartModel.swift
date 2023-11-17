//
//  CartModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/09/2023.
//

import Foundation
import ObjectMapper

class CartModel: Mappable {
    
    var total: Int?
    var subtotal: Int?
    var subtotalBeforeDiscount: Int?
    var products: [ProductModel]?
    
    func mapping(map: Map) {
        total <- map["total"]
        subtotal <- map["subtotal"]
        subtotalBeforeDiscount <- map["subtotal_before_discount"]
        products <- map["products"]
    }
    
    required init?(map: Map) {

    }
}
