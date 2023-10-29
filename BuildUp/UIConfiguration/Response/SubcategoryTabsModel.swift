//
//  SubcategoryTabsModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/09/2023.
//

import Foundation
import ObjectMapper

class SubcategoryTabsModel: NSObject, NSCoding, Mappable {
    var isActive: Bool?
    var design: String?
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        isActive <- map["is_active"]
        design <- map["design"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
        design = aDecoder.decodeObject(forKey: "design") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if isActive != nil {
            aCoder.encode(isActive, forKey: "isActive")
        }
        if design != nil {
            aCoder.encode(design, forKey: "design")
        }
    }
}
