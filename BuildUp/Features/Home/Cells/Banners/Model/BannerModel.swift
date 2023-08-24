//
//  BannerModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/08/2023.
//

import Foundation
import ObjectMapper

class BannerModel: NSObject, NSCoding, Mappable {
    var name: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if name != nil {
            aCoder.encode(name, forKey: "name")
        }
    }
}
