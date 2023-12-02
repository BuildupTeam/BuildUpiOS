//
//  OrderModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import Foundation
import ObjectMapper

class OrderModel: Mappable {
    
    var uuid: String?
    var total: Double?
    var status: String?
    var paymentMethod: String?
    var createdAt: String?
    var formattedTotal: FormatedPriceModel?
    var products: [ProductModel]?
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        total <- map["total"]
        status <- map["status"]
        paymentMethod <- map["payment_method"]
        createdAt <- map["created_at"]
        formattedTotal <- map["formatted_total"]
        products <- map["products"]
    }
    
    required init?(map: Map) {

    }
}
