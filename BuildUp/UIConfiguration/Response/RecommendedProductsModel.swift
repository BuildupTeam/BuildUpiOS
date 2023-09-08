//
//  RecommendedProductsModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import Foundation
import ObjectMapper

class RecommendedProductsModel: NSObject, NSCoding, Mappable {
    var isActive: Bool?
    var design: String?
    var displayTitle: Bool?
    var displaySeeMore: Bool?
    var title: String?
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        isActive <- map["is_active"]
        design <- map["design"]
        displayTitle <- map["display_title"]
        displaySeeMore <- map["display_see_more"]
        title <- map["title"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
        design = aDecoder.decodeObject(forKey: "design") as? String
        displayTitle = aDecoder.decodeObject(forKey: "displayTitle") as? Bool
        displaySeeMore = aDecoder.decodeObject(forKey: "displaySeeMore") as? Bool
        title = aDecoder.decodeObject(forKey: "title") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if isActive != nil {
            aCoder.encode(isActive, forKey: "isActive")
        }
        if design != nil {
            aCoder.encode(design, forKey: "design")
        }
        if displayTitle != nil {
            aCoder.encode(displayTitle, forKey: "displayTitle")
        }
        if displaySeeMore != nil {
            aCoder.encode(displaySeeMore, forKey: "displaySeeMore")
        }
        if title != nil {
            aCoder.encode(title, forKey: "title")
        }
    }
}
