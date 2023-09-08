//
//  ProductDetailsOptionsModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/09/2023.
//

import Foundation
import ObjectMapper

class ProductDetailsOptionsModel: Mappable {
    var option: ProductDetailsOptionModel?
    var optionValues: [ProductDetailsOptionValueModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        option <- map["option"]
        optionValues <- map["option_values"]
    }
}
