//
//  OrderModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import Foundation
import ObjectMapper

class OrderModel: Mappable {
    
    var id: Int?
    var name: String?
    var cityId: Int?
    var products: [ProductModel]?

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        cityId <- map["city_id"]
        products <- map["products"]
    }
    
    required init?(map: Map) {

    }
}
