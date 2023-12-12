//
//  CheckoutDataModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 12/12/2023.
//

import Foundation
import ObjectMapper

class CheckoutDataModel: Mappable {
    
    var order: OrderModel?
    var paymentMethod: String?
    var confirmed: Bool?

    func mapping(map: Map) {
        order <- map["order"]
        paymentMethod <- map["payment_method"]
        confirmed <- map["confirmed"]
    }
    
    required init?(map: Map) {

    }
}
