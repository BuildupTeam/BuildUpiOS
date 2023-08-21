//
//  ComponentArabicTranslationModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class ComponentArabicTranslationModel: NSObject, NSCoding, Mappable {
    var ar: String?

    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        ar <- map["ar"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        ar = aDecoder.decodeObject(forKey: "ar") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if ar != nil {
            aCoder.encode(ar, forKey: "ar")
        }
    }
}
