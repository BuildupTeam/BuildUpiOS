//
//  AdStatusModel.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import ObjectMapper

class AdStatusModel: Mappable {
    
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
