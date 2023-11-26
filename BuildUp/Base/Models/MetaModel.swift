//
//  MetaModel.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import ObjectMapper

class MetaModel: Mappable {
    
    var currentPage: Int?
    var from: Int?
    var lastPage: Int?
    var to: Int?
    var perPage: Int?
    var total: Int?
    
    var totalCount: Int?

    func mapping(map: Map) {
        currentPage <- map["current_page"]
        from <- map["from"]
        to <- map["to"]
        lastPage <- map["last_page"]
        perPage <- map["per_page"]
        total <- map["total"]
    }
    
    required init?(map: Map) {

    }
}
