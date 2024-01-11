//
//  CartCombinationsOptionModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 13/11/2023.
//

import Foundation
import ObjectMapper

class CartCombinationsOptionModel: Mappable {
    var option: CartOptionModel?
    var optionValue: CartOptionModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        option <- map["option"]
        optionValue <- map["option_value"]
    }
}
