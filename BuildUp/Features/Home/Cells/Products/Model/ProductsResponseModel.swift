//
//  ProductsResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/08/2023.
//

import Foundation
import ObjectMapper

class ProductsResponseModel: BaseResponse {

    var data: [ProductModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
