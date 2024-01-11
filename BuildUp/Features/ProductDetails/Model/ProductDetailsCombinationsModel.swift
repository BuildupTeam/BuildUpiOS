//
//  ProductDetailsCombinationsModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 08/09/2023.
//

import Foundation
import ObjectMapper

class ProductDetailsCombinationsModel: Mappable {
    var id: Int?
    var options: [CompinationsOptionModel]?
    var price: Double?
    var currentPrice: Double?
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
    }
}
