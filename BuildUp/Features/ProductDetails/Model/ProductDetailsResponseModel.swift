//
//  ProductDetailsResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import Foundation
import ObjectMapper

class ProductDetailsResponseModel: BaseResponse {

    var data: ProductModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
