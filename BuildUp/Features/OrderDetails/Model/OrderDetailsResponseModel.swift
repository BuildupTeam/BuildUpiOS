//
//  OrderDetailsResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import Foundation
import ObjectMapper

class OrderDetailsResponseModel: BaseResponse {
    
    var data: OrderModel?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
