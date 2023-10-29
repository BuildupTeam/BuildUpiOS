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
    var productDescription: String?
    var originalPrice: Int?
    var currentPrice: Int?
    var formattedPrice: FormatedPriceModel?
    var discount: Int?
    var mainImage: MainImageModel?
    var files: [ProductFileModel]?
    var categories: [CategoryModel]?
    var subcategories: [CategoryModel]?
    var quantity: Int?
    var orderInOutOfStock: Bool?
    var options: [ProductDetailsOptionsModel]?
    var relatedProducts: [ProductModel]?
    var combinations: [ProductDetailsCombinationsModel]?
    var maxAddedQuantity: Int?
    var quantitySelected = 1
    var subtotalPrice = 0
    var descriptionIsExpaned = false
    
    var selectedCombinationPrice: Int? {
        return getSelectedCombinationPrice()
    }
    
    var selectedCombination: ProductDetailsCombinationsModel? {
        return getSelectedCombination()
    }
    
    var selectedValues: [Int] {
        return getSelectedOptions()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        slug <- map["slug"]
        uuid <- map["uuid"]
        name <- map["name"]
        productDescription <- map["description"]
        originalPrice <- map["original_price"]
        currentPrice <- map["current_price"]
        formattedPrice <- map["formatted_price"]
        discount <- map["discount"]
        mainImage <- map["main_image"]
        files <- map["files"]
        categories <- map["categories"]
        subcategories <- map["subcategories"]
        quantity <- map["quantity"]
        quantity <- map["order_in_out_of_stock"]
        options <- map["options"]
        combinations <- map["combinations"]
        maxAddedQuantity <- map["max_added_quantity"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        uuid = aDecoder.decodeObject(forKey: "uuid") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        productDescription = aDecoder.decodeObject(forKey: "productDescription") as? String
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
        if productDescription != nil {
            aCoder.encode(productDescription, forKey: "productDescription")
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
    
    private func getSelectedOptions() -> [Int] {
        var selectedValues: [ProductDetailsOptionValueModel] = []
        
        for option in options ?? [] {
            selectedValues.append(contentsOf: option.optionValues?.filter({ (value) -> Bool in
                return value.isSelected
            }) ?? [])
        }
        
        return selectedValues.map { $0.id ?? 0 }
    }
    
    private func getSelectedCombinationPrice() -> Int? {
        for combination in combinations ?? [] {
            let combinationIds = combination.options?.map({$0.optionValueId ?? 0}) ?? []
            if combinationIds.containsSameElements(as: selectedValues) {
                return combination.price
            }
        }
        return 0
    }
    
    private func getSelectedCombination() -> ProductDetailsCombinationsModel? {
        for combination in combinations ?? [] {
            let combinationIds = combination.options?.map({$0.optionValueId ?? 0}) ?? []
            if combinationIds.containsSameElements(as: selectedValues) {
                return combination
            }
        }
        return nil
    }
}
