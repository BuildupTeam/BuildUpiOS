//
//  SummaryData.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import ObjectMapper

class SummaryData: Mappable {
    
    var summary: SummaryModel?
    var products: [ProductModel]?

    func mapping(map: Map) {
        summary <- map["summary"]
        products <- map["products"]
    }
    
    required init?(map: Map) {

    }
}
