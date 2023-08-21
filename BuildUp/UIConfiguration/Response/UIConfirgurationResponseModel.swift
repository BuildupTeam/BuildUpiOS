//
//  UIConfirgurationResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class UIConfirgurationResponseModel: BaseResponse {

    var data: ThemeConfigurationDataModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
