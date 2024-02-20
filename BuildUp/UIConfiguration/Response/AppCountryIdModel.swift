//
//  AppCountryIdModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 18/02/2024.
//

import Foundation
import ObjectMapper

class AppCountryIdModel: NSObject, NSCoding, Mappable {
    var id: Int?
    var name: String?
    var iso: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        iso <- map["iso"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        iso = aDecoder.decodeObject(forKey: "iso") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if name != nil {
            aCoder.encode(name, forKey: "name")
        }
        if iso != nil {
            aCoder.encode(iso, forKey: "iso")
        }
    }
}
