//
//  PaymentMethodsData.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/12/2023.
//

import Foundation
import ObjectMapper

class PaymentMethodsData: Mappable {
    
    var paymentMethods: [PaymentMethodModel]?

    func mapping(map: Map) {
        paymentMethods <- map["payment_methods"]
    }
    
    required init?(map: Map) {

    }
}
