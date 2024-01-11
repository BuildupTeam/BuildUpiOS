//
//  PaymentMethodModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/12/2023.
//

import Foundation
import ObjectMapper

class PaymentMethodModel: Mappable {
    
    var id: Int?
    var identifier: String?
    var name: String?
    var image: String?
    var isSelected = false
    var gateway: PaymentGatewayModel?

    func mapping(map: Map) {
        id <- map["id"]
        identifier <- map["identifier"]
        name <- map["name"]
        image <- map["image"]
        gateway <- map["gateway"]
    }
    
    required init?(map: Map) {

    }
}
