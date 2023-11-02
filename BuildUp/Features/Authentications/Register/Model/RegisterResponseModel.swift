//
//  RegisterResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation
import ObjectMapper

class RegisterResponseModel: BaseResponse {
    
    var data: UserModel?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
