//
//  ProductListResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import Foundation
import ObjectMapper

class ProductListResponseModel: BaseResponse {

    var data: [ProductModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
