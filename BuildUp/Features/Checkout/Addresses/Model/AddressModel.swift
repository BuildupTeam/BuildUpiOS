//
//  AddressModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import ObjectMapper

class AddressModel: Mappable {
    
    var id: Int?
    var addressDescription: String?
    var isDefault: Bool?
    var country: CountryModel?
    var city: CityModel?
    
    func mapping(map: Map) {
        id <- map["id"]
        addressDescription <- map["description"]
        isDefault <- map["is_default"]
        country <- map["country"]
        city <- map["city"]
    }
    
    required init?(map: Map) {

    }
}
