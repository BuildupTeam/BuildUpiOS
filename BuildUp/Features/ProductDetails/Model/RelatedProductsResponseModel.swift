//
//  RelatedProductsResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 08/09/2023.
//

import Foundation
import ObjectMapper

class RelatedProductsResponseModel: BaseResponse {

    var data: [ProductModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
