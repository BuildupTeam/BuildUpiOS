//
//  ProductDetailsCombinationsModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 08/09/2023.
//

import Foundation
import ObjectMapper

class ProductDetailsCombinationsModel: Mappable {
    var options: [CompinationsOptionModel]?
    var price: Int?
    var quantity: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        options <- map["options"]
        price <- map["price"]
        quantity <- map["quantity"]
    }
}
