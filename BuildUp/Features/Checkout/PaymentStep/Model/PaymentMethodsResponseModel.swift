//
//  PaymentMethodsResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/12/2023.
//

import Foundation
import ObjectMapper

class PaymentMethodsResponseModel: BaseResponse {
    
    var data: [PaymentMethodModel]?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
