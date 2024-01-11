//
//  PaymentGatewayModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/01/2024.
//

import Foundation
import ObjectMapper

class PaymentGatewayModel: Mappable {
    
    var identifier: String?
    var config: String?

    func mapping(map: Map) {
        identifier <- map["identifier"]
        config <- map["config"]
    }
    
    required init?(map: Map) {

    }
}
