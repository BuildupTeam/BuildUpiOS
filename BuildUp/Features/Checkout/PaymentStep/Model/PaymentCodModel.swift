//
//  PaymentCodModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/12/2023.
//

import Foundation
import ObjectMapper

class PaymentCodModel: Mappable {
    
    var enabled: String?

    func mapping(map: Map) {
        enabled <- map["enabled"]
    }
    
    required init?(map: Map) {

    }
}
