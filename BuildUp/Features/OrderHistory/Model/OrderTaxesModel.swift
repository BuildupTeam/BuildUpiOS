//
//  OrderTaxesModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 07/02/2024.
//

import Foundation
import ObjectMapper

class OrderTaxesModel: Mappable {
    
    var amount: FormatedPriceModel?
    var rate: Double?
    var name: String?
    
    
    func mapping(map: Map) {
        amount <- map["amount"]
        rate <- map["rate"]
        name <- map["name"]
    }
    
    required init?(map: Map) {

    }
}
