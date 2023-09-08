//
//  SettingsConfigurationModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import Foundation
import ObjectMapper

class SettingsConfigurationModel: NSObject, NSCoding, Mappable {
    var slider: String?
    var actions: String?
    var variants: String?
    var quantityPosition: String?
    var quantityStyle: String?
    var recommendedProducts: RecommendedProductsModel?
                   
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        slider <- map["slider"]
        actions <- map["actions"]
        variants <- map["variants"]
        quantityPosition <- map["quantity_position"]
        quantityStyle <- map["quantity_style"]
        recommendedProducts <- map["recommended_products"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        slider = aDecoder.decodeObject(forKey: "slider") as? String
        actions = aDecoder.decodeObject(forKey: "actions") as? String
        variants = aDecoder.decodeObject(forKey: "variants") as? String
        quantityPosition = aDecoder.decodeObject(forKey: "quantityPosition") as? String
        quantityStyle = aDecoder.decodeObject(forKey: "quantityStyle") as? String
        recommendedProducts = aDecoder.decodeObject(forKey: "recommendedProducts") as? RecommendedProductsModel
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if slider != nil {
            aCoder.encode(slider, forKey: "slider")
        }
        if actions != nil {
            aCoder.encode(actions, forKey: "actions")
        }
        if variants != nil {
            aCoder.encode(variants, forKey: "variants")
        }
        if quantityPosition != nil {
            aCoder.encode(quantityPosition, forKey: "quantityPosition")
        }
        if quantityStyle != nil {
            aCoder.encode(quantityStyle, forKey: "quantityStyle")
        }
        if recommendedProducts != nil {
            aCoder.encode(recommendedProducts, forKey: "recommendedProducts")
        }
    }
}
