//
//  ProfileResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/12/2023.
//

import Foundation
import ObjectMapper

class ProfileResponseModel: BaseResponse {
    
    var data: CustomerModel?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
