//
//  CategoriesResponseModel.swift
//  flyers
//
//  Created by Mahmoud Nasser on 20/10/2022.
//

import Foundation
import ObjectMapper

class CategoriesResponseModel: BaseResponse {

    var data: [CategoryModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
