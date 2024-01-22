//
//  CurserMetaModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 11/01/2024.
//

import Foundation
import ObjectMapper

class CurserMetaModel: Mappable {
    
    var nextCursor: String?
    var prevCursor: String?
    
    func mapping(map: Map) {
        nextCursor <- map["next_cursor"]
        prevCursor <- map["prev_cursor"]
    }
    
    required init?(map: Map) {

    }
}
