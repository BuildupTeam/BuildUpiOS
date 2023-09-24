//
//  ComponentsFilterModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class ComponentsFilterModel: NSObject, NSCoding, Mappable {
    var discount: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        discount <- map["discount"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        discount = aDecoder.decodeObject(forKey: "discount") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if discount != nil {
            aCoder.encode(discount, forKey: "discount")
        }
    }
}
