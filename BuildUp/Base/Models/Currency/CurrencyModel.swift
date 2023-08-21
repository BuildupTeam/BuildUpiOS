//
//  CurrencyModel.swift
//  flyers
//
//  Created by Mahmoud Nasser on 09/12/2022.
//

import Foundation
import UIKit
import ObjectMapper

class CurrencyModel: NSObject, NSCoding, Mappable {
    
    var id: Int?
    var name: String?
    var symbol: String?
    
    override init() {
    }

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        symbol <- map["symbol"]
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        symbol = aDecoder.decodeObject(forKey: "symbol") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if name != nil {
            aCoder.encode(name, forKey: "name")
        }
        if symbol != nil {
            aCoder.encode(symbol, forKey: "symbol")
        }
    }
}
