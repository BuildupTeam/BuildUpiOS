//
//  CategoryModel.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import UIKit
import ObjectMapper

class CategoryModel: NSObject, NSCoding, Mappable {
    
    var id: Int?
    var name: String?
    var image: MainImageModel?
    var isSelected: Bool = false
    
    override init() {
    }

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        image = aDecoder.decodeObject(forKey: "image") as? MainImageModel
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if name != nil {
            aCoder.encode(name, forKey: "name")
        }
        if image != nil {
            aCoder.encode(image, forKey: "image")
        }
    }
}
