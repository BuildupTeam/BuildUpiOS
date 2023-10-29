//
//  CartSummeryModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 28/09/2023.
//

import Foundation
import ObjectMapper

class CartSummeryModel: NSObject, NSCoding, Mappable {
    var isActive: Bool?
    var position: String?
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        isActive <- map["is_active"]
        position <- map["position"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
        position = aDecoder.decodeObject(forKey: "position") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if isActive != nil {
            aCoder.encode(isActive, forKey: "isActive")
        }
        if position != nil {
            aCoder.encode(position, forKey: "position")
        }
    }
}
