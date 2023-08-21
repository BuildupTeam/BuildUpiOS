//
//  ComponentCategoryModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class ComponentCategoryModel: NSObject, NSCoding, Mappable {
    var id: Int?
    var isMain: Bool?
    var createdAt: String?
    var updatedAt: String?
    var name: String?

    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        isMain <- map["is_main"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        name <- map["name"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isMain = aDecoder.decodeObject(forKey: "isMain") as? Bool
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if isMain != nil {
            aCoder.encode(isMain, forKey: "isMain")
        }
        if createdAt != nil {
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if updatedAt != nil {
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        if name != nil {
            aCoder.encode(name, forKey: "name")
        }
    }
}
