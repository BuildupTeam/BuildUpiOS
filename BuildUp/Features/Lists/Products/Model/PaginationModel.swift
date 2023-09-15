//
//  PaginationModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import Foundation
import ObjectMapper

class PaginationModel: Mappable {
    
    var currentPage: Int?
    var from: Int?
    var to: Int?
    var lastPage: Int?
    var perPage: Int?
    var perPageString: String? {
        didSet {
           perPage = Int(perPageString ?? "") ?? 0
        }
    }
    var total: Int?

    func mapping(map: Map) {
        currentPage <- map["current_page"]
        from <- map["from"]
        to <- map["to"]
        lastPage <- map["last_page"]
        perPageString <- map["per_page"]
        total <- map["total"]
    }
    
    required init?(map: Map) {

    }
}
