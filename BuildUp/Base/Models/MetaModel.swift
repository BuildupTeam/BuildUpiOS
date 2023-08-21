//
//  MetaModel.swift
//  flyers
//
//  Created by Mahmoud Nasser on 27/09/2022.
//

import Foundation
import ObjectMapper

class MetaModel: Mappable {
    
    var currentPage: Int?
    var from: Int?
    var totalPages: Int?
    var perPage: Int?
    var totalRecords: Int?
    
    var totalCount: Int?

    func mapping(map: Map) {
        currentPage <- map["current_page"]
        from <- map["from"]
        totalPages <- map["total_pages"]
        perPage <- map["payload_size"]
        totalRecords <- map["total"]
        totalCount <- map["filter_count"]
    }
    
    required init?(map: Map) {

    }
}
