//
//  CartResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/09/2023.
//

import Foundation
import ObjectMapper

class CartResponseModel: BaseResponse {
    
    var data: CartModel?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
