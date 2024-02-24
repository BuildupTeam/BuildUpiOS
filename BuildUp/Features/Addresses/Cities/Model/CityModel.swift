//
//  CityModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import Foundation
import ObjectMapper

class CityModel: Mappable {
    
    var id: Int?
    var name: String?
    var countryId: Int?

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        countryId <- map["country_id"]
    }
    
    required init?(map: Map) {

    }
}
