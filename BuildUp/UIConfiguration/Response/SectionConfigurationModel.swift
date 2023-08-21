//
//  SectionConfigurationModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class SectionConfigurationModel: NSObject, NSCoding, Mappable {
    var id: Int?
    var order: Int?
    var isActive: Bool?
    var type: Int?
    var components: [ComponentConfigurationModel]?

    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        order <- map["order"]
        isActive <- map["is_active"]
        type <- map["type"]
        components <- map["components"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        order = aDecoder.decodeObject(forKey: "order") as? Int
        isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
        type = aDecoder.decodeObject(forKey: "type") as? Int
        components = aDecoder.decodeObject(forKey: "components") as? [ComponentConfigurationModel]
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if order != nil {
            aCoder.encode(order, forKey: "order")
        }
        if isActive != nil {
            aCoder.encode(isActive, forKey: "isActive")
        }
        if type != nil {
            aCoder.encode(type, forKey: "type")
        }
        if components != nil {
            aCoder.encode(components, forKey: "components")
        }
    }
}
