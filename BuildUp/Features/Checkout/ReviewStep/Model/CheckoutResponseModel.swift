//
//  CheckoutResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 12/12/2023.
//

import Foundation
import ObjectMapper

class CheckoutResponseModel: BaseResponse {
    
    var data: CheckoutDataModel?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
