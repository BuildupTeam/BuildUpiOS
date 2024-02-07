//
//  CartCombinationsModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 13/11/2023.
//

import Foundation
import ObjectMapper

class CartCombinationsModel: Mappable {
    var id: Int?
    var options: [CartCombinationsOptionModel]?
    var price: FormatedPriceModel?
    var currentPrice: FormatedPriceModel?
    var quantity: Int?
    var cartQuantity: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        options <- map["options"]
        price <- map["price"]
        currentPrice <- map["current_price"]
        quantity <- map["quantity"]
        cartQuantity <- map["cart_quantity"]
    }
}
