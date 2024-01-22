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
    var originalPrice: Double?
    var currentPrice: Double?
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
    var cartCombinations: [CartCombinationsModel]?
    var maxAddedQuantity: Int?
    var quantitySelected = 0  // TODO: - change to cart quantity
    var cartQuantity: Int?
    var subtotalPrice = 0
    var descriptionIsExpaned = false
    var isFavorite = false
    var hasCombinations: Bool?
    
    var totalPriceOriginal: Double? {
        return (originalPrice ?? 0) * Double((cartQuantityValue ?? 0))
    }
    
    var totalPriceCurrent: Double? {
        return (currentPrice ?? 0) * Double((cartQuantityValue ?? 0))
    }
    
    var totalPriceCombinationOriginal: Double? {
        return (cartCombinations?.first?.price ?? 0) * Double((cartQuantityValue ?? 0))
    }
    
    var totalPriceCombinationCurrent: Double? {
        return (cartCombinations?.first?.currentPrice ?? 0) * Double((cartQuantityValue ?? 0))
    }
    
    var cartQuantityValue: Int? {
        return (cartQuantity != nil) ? cartQuantity : cartCombinations?.first?.cartQuantity
    }
    
    var quantityValue: Int? {
        return (quantity != nil) ? quantity : cartCombinations?.first?.quantity
    }
    
    var selectedCombinationPrice: Double? {
        return getSelectedCombinationPrice()
    }
    
    var selectedCombination: ProductDetailsCombinationsModel? {
        return getSelectedCombination()
    }
    
    var selectedValues: [Int] {
        return getSelectedOptions()
    }
    
    func getMaxQuantity() -> Int {
        var maxQuantity = 0
        
        if selectedCombination != nil {
            maxQuantity = selectedCombination?.quantity ?? 0
        } else {
            maxQuantity = quantity ?? 0
        }
        
        if orderInOutOfStock ?? false {
            return (maxAddedQuantity ?? 0)
        } else {
            if maxQuantity > (maxAddedQuantity ?? 0) {
                return (maxAddedQuantity ?? 0)
            } else {
                return maxQuantity
            }
        }
    }
    
    func getCartMaxQuantity() -> Int {
        var maxQuantity = 0
        
        if (cartCombinations?.first) != nil {
            maxQuantity = cartCombinations?.first?.cartQuantity ?? 0
        } else {
            maxQuantity = quantity ?? 0
        }
        
        if orderInOutOfStock ?? false {
            return (maxAddedQuantity ?? 0)
        } else {
            if maxQuantity > (maxAddedQuantity ?? 0) {
                return (maxAddedQuantity ?? 0)
            } else {
                return maxQuantity
            }
        }
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
        orderInOutOfStock <- map["order_in_out_of_stock"]
        options <- map["options"]
        combinations <- map["combinations"]
        cartCombinations <- map["combinations"]
        maxAddedQuantity <- map["max_added_quantity"]
        cartQuantity <- map["cart_quantity"]
        hasCombinations <- map["has_combinations"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        slug = aDecoder.decodeObject(forKey: "slug") as? String
        uuid = aDecoder.decodeObject(forKey: "uuid") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        productDescription = aDecoder.decodeObject(forKey: "productDescription") as? String
        originalPrice = aDecoder.decodeObject(forKey: "originalPrice") as? Double
        currentPrice = aDecoder.decodeObject(forKey: "currentPrice") as? Double
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
    
    private func getSelectedCombinationPrice() -> Double? {
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
