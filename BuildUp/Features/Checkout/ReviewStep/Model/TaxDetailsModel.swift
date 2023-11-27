//
//  TaxDetailsModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import ObjectMapper

class TaxDetailsModel: Mappable {
    
    var name: String?
    var amount: Double?
    var rate: Double?

    func mapping(map: Map) {
        name <- map["name"]
        amount <- map["amount"]
        rate <- map["rate"]
    }
    
    required init?(map: Map) {

    }
}
