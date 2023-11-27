//
//  SummaryResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import ObjectMapper

class SummaryResponseModel: BaseResponse {
    
    var data: SummaryData?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
