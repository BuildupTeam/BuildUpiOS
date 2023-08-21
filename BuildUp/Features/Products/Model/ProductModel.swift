//
//  ProductModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/07/2023.
//

import Foundation
import ObjectMapper

class ProductModel: NSObject, NSCoding, Mappable {
    var slug: String?
    var uuid: String?
    var name: String?
    var originalPrice: Int?
    var currentPrice: Int?
    var formattedPrice: FormatedPriceModel?
    var discount: Int?
    var mainImage: MainImageModel?
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        slug <- map["slug"]
        uuid <- map["uuid"]
        name <- map["name"]
        originalPrice <- map["original_price"]
        currentPrice <- map["current_price"]
        formattedPrice <- map["formatted_price"]
        discount <- map["discount"]
        mainImage <- map["main_image"]

    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        uuid = aDecoder.decodeObject(forKey: "uuid") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        originalPrice = aDecoder.decodeObject(forKey: "originalPrice") as? Int
        currentPrice = aDecoder.decodeObject(forKey: "currentPrice") as? Int
        formattedPrice = aDecoder.decodeObject(forKey: "formattedPrice") as? FormatedPriceModel
        discount = aDecoder.decodeObject(forKey: "discount") as? Int
        mainImage = aDecoder.decodeObject(forKey: "mainImage") as? MainImageModel

    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if slug != nil {
            aCoder.encode(slug, forKey: "slug")
        }
        if uuid != nil {
            aCoder.encode(uuid, forKey: "uuid")
        }
        if name != nil {
            aCoder.encode(name, forKey: "name")
        }
        if originalPrice != nil {
            aCoder.encode(originalPrice, forKey: "originalPrice")
        }
        if currentPrice != nil {
            aCoder.encode(currentPrice, forKey: "currentPrice")
        }
        if formattedPrice != nil {
            aCoder.encode(formattedPrice, forKey: "formattedPrice")
        }
        if discount != nil {
            aCoder.encode(discount, forKey: "discount")
        }
        if mainImage != nil {
            aCoder.encode(mainImage, forKey: "mainImage")
        }
        
    }
}
