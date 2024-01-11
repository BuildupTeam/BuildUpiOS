//
//  FirebaseFavoriteModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/11/2023.
//

import Foundation
import ObjectMapper

class FirebaseFavoriteModel: Mappable {
    
    var uuid: String?
    var isFavorite: Bool?
    var createdAt: Double?
    
    init(uuid: String? = nil, isFavorite: Bool? = nil, createdAt: Double? = nil) {
        self.uuid = uuid
        self.isFavorite = isFavorite
        self.createdAt = createdAt
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        isFavorite <- map["isFavorite"]
        createdAt <- map["createdAt"]
    }
        
    var dict: [String: Any] {
        return ["createdAt": createdAt ?? Int(Date().timeIntervalSince1970 * 1000)]
    }
}
