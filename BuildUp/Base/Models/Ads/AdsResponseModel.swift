//
//  AdsResponseModel.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import ObjectMapper

class AdsResponseModel: BaseResponse {

    var data: [AdModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
