//
//  CountriesResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import Foundation
import ObjectMapper

class CountriesResponseModel: BaseResponse {
    
    var data: [CountryModel]?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
