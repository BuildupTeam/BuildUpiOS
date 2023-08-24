//
//  MainImageModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/08/2023.
//

import Foundation
import ObjectMapper

class MainImageModel: NSObject, NSCoding, Mappable {
    var id: Int?
    var path: String?
    var originalName: String?
    var mimeType: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        path <- map["path"]
        originalName <- map["original_name"]
        mimeType <- map["mime_type"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        path = aDecoder.decodeObject(forKey: "path") as? String
        originalName = aDecoder.decodeObject(forKey: "originalName") as? String
        mimeType = aDecoder.decodeObject(forKey: "mimeType") as? String
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
        if mimeType != nil {
            aCoder.encode(mimeType, forKey: "mimeType")
        }
    }
}
