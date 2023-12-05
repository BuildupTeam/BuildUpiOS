//
//  AddressesResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import ObjectMapper

class AddressesResponseModel: BaseResponse {
    
    var data: [AddressModel]?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
