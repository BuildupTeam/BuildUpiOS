//
//  ComponentConfigurationModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class ComponentConfigurationModel: NSObject, NSCoding, Mappable {
    var id: Int?
    var design: String?
    var contentType: String?
    var orderBy: String?
    var orderDir: String?
    var backgroundColor: String?
    var displayTitle: Bool?
    var allowShowMore: Bool?
    var backgroundImage: MainImageModel?
    var image: MainImageModel?
    var filters: ComponentsFilterModel?
    var title: String?
    var categories: [ComponentCategoryModel]?
    var images: [String]?

    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        design <- map["design"]
        contentType <- map["content_type"]
        orderBy <- map["order_by"]
        orderDir <- map["order_dir"]
        backgroundColor <- map["background_color"]
        displayTitle <- map["display_title"]
        allowShowMore <- map["allow_show_more"]
        backgroundImage <- map["background_image"]
        image <- map["image"]
        filters <- map["filters"]
        title <- map["title"]
        categories <- map["categories"]
        images <- map["images"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        design = aDecoder.decodeObject(forKey: "design") as? String
        contentType = aDecoder.decodeObject(forKey: "contentType") as? String
        orderBy = aDecoder.decodeObject(forKey: "orderBy") as? String
        orderDir = aDecoder.decodeObject(forKey: "orderDir") as? String
        backgroundColor = aDecoder.decodeObject(forKey: "backgroundColor") as? String
        displayTitle = aDecoder.decodeObject(forKey: "displayTitle") as? Bool
        allowShowMore = aDecoder.decodeObject(forKey: "allowShowMore") as? Bool
        backgroundImage = aDecoder.decodeObject(forKey: "backgroundImage") as? MainImageModel
        image = aDecoder.decodeObject(forKey: "image") as? MainImageModel
        filters = aDecoder.decodeObject(forKey: "filters") as? ComponentsFilterModel
        title = aDecoder.decodeObject(forKey: "title") as? String
        categories = aDecoder.decodeObject(forKey: "categories") as? [ComponentCategoryModel]
        images = aDecoder.decodeObject(forKey: "images") as? [String]
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if design != nil {
            aCoder.encode(design, forKey: "design")
        }
        if contentType != nil {
            aCoder.encode(contentType, forKey: "contentType")
        }
        if orderBy != nil {
            aCoder.encode(orderBy, forKey: "orderBy")
        }
        if orderDir != nil {
            aCoder.encode(orderDir, forKey: "orderDir")
        }
        if backgroundColor != nil {
            aCoder.encode(backgroundColor, forKey: "backgroundColor")
        }
        if displayTitle != nil {
            aCoder.encode(displayTitle, forKey: "displayTitle")
        }
        if allowShowMore != nil {
            aCoder.encode(allowShowMore, forKey: "allowShowMore")
        }
        if backgroundImage != nil {
            aCoder.encode(backgroundImage, forKey: "backgroundImage")
        }
        if image != nil {
            aCoder.encode(image, forKey: "image")
        }
        if filters != nil {
            aCoder.encode(filters, forKey: "filters")
        }
        if title != nil {
            aCoder.encode(title, forKey: "title")
        }
        if categories != nil {
            aCoder.encode(categories, forKey: "categories")
        }
        if images != nil {
            aCoder.encode(images, forKey: "images")
        }
    }
}

