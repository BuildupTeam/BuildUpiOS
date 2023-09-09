//
//  CompinationsOptionModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 08/09/2023.
//

import Foundation
import ObjectMapper

class CompinationsOptionModel: Mappable {
    var optionId: Int?
    var optionValueId: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        optionId <- map["option_id"]
        optionValueId <- map["option_value_id"]
    }
}
