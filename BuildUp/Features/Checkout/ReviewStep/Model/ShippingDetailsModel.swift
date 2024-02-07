//
//  ShippingDetailsModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import ObjectMapper

class ShippingDetailsModel: Mappable {
    
    var name: String?
    var amount: FormatedPriceModel?

    func mapping(map: Map) {
        name <- map["name"]
        amount <- map["amount"]
    }
    
    required init?(map: Map) {

    }
}
