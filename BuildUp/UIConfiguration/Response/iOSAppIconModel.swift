//
//  iOSAppIconModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/02/2024.
//

import Foundation
import ObjectMapper

class iOSAppIconModel: NSObject, NSCoding, Mappable {
    var id: Int?
    var path: String?
    var originalName: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        path <- map["path"]
        originalName <- map["original_name"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        path = aDecoder.decodeObject(forKey: "path") as? String
        originalName = aDecoder.decodeObject(forKey: "originalName") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if path != nil {
            aCoder.encode(path, forKey: "path")
        }
        if originalName != nil {
            aCoder.encode(originalName, forKey: "originalName")
        }
    }
}
