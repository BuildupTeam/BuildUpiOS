//
//  HomeSectionModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/07/2023.
//

import Foundation

class HomeSectionModel: NSObject, NSCoding {
    var order: Int?
    var contentType: String?
    var component: ComponentConfigurationModel?
    
    var products: [ProductModel]?
    var categories: [CategoryModel]?
    var banners: [BannerModel]?
    
    init(order: Int,
         contentType: String,
         component: ComponentConfigurationModel?,
         products: [ProductModel]? = nil,
         categories: [CategoryModel]? = nil) {
        self.order = order
        self.contentType = contentType
        self.component = component
        self.products = products
        self.categories = categories
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        order = aDecoder.decodeObject(forKey: "order") as? Int

        contentType = aDecoder.decodeObject(forKey: "contentType") as? String
        component = aDecoder.decodeObject(forKey: "component") as? ComponentConfigurationModel
        products = aDecoder.decodeObject(forKey: "products") as? [ProductModel]
        categories = aDecoder.decodeObject(forKey: "categories") as? [CategoryModel]
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if order != nil {
            aCoder.encode(order, forKey: "order")
        }
        if contentType != nil {
            aCoder.encode(contentType, forKey: "contentType")
        }
        if component != nil {
            aCoder.encode(component, forKey: "component")
        }
        if products != nil {
            aCoder.encode(products, forKey: "products")
        }
        if categories != nil {
            aCoder.encode(categories, forKey: "categories")
        }
    }
}
