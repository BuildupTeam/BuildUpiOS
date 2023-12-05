//
//  AreaModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation
import ObjectMapper

class AreaModel: Mappable {
    
    var id: Int?
    var name: String?
    var cityId: Int?

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        cityId <- map["city_id"]
    }
    
    required init?(map: Map) {

    }
}
