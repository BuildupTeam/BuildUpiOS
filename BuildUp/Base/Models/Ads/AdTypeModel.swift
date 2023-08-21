//
//  AdTypeModel.swift
//  flyers
//
//  Created by Mahmoud Nasser on 06/10/2022.
//

import Foundation
import ObjectMapper

class AdTypeModel: Mappable {
    
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
