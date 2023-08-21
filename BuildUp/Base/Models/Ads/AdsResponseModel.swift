//
//  AdsResponseModel.swift
//  flyers
//
//  Created by Mahmoud Nasser on 06/10/2022.
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
