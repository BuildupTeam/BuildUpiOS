//
//  CartModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/09/2023.
//

import Foundation
import ObjectMapper

class CartModel: Mappable {
    
    var formattedTotal: FormatedPriceModel?
    var formattedSubtotal: FormatedPriceModel?
    var subtotalBeforeDiscount: FormatedPriceModel?
    var products: [ProductModel]?
    
    func mapping(map: Map) {
        formattedTotal <- map["formatted_total"]
        formattedSubtotal <- map["formatted_subtotal"]
        subtotalBeforeDiscount <- map["subtotal_before_discount"]
        products <- map["products"]
    }
    
    required init?(map: Map) {

    }
}
