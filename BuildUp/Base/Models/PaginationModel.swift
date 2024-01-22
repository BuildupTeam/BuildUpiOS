//
//  PaginationModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 11/01/2024.
//

import Foundation
import ObjectMapper

class PaginationModel: Mappable {
    
    var currentPage: Int?
    var from: Int?
    var lastPage: Int?
    var to: Int?
    var perPage: Int?
    var total: Int?
    var cursorMeta: CurserMetaModel?
    
    func mapping(map: Map) {
        currentPage <- map["current_page"]
        from <- map["from"]
        to <- map["to"]
        lastPage <- map["last_page"]
        perPage <- map["per_page"]
        total <- map["total"]
        cursorMeta <- map["cursor_meta"]
    }
    
    required init?(map: Map) {

    }
}
