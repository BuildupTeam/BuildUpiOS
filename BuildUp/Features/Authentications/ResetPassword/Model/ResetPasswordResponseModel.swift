//
//  ResetPasswordResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/11/2023.
//

import Foundation
import ObjectMapper

class ResetPasswordResponseModel: BaseResponse {
    
    var data: UserModel?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}