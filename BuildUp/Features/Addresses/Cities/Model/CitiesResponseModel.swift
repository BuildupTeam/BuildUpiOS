//
//  CitiesResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import Foundation
import ObjectMapper

class CitiesResponseModel: BaseResponse {
    
    var data: [CityModel]?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
