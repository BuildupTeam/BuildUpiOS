//
//  CountryModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import Foundation
import ObjectMapper

class CountryModel: Mappable {
    
    var id: Int?
    var name: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
    required init?(map: Map) {

    }
}

