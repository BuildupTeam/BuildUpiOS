//
//  ComponentEnglishTranslationModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class ComponentEnglishTranslationModel: NSObject, NSCoding, Mappable {
    var en: String?

    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        en <- map["en"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        en = aDecoder.decodeObject(forKey: "en") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if en != nil {
            aCoder.encode(en, forKey: "en")
        }
    }
}
