//
//  FormatedPriceModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/08/2023.
//

import Foundation
import ObjectMapper

class FormatedPriceModel: NSObject, NSCoding, Mappable {
    var amount: Int?
    var formatted: String?
    var currency: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        formatted <- map["formatted"]
        currency <- map["currency"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        amount = aDecoder.decodeObject(forKey: "amount") as? Int
        formatted = aDecoder.decodeObject(forKey: "formatted") as? String
        currency = aDecoder.decodeObject(forKey: "currency") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if amount != nil {
            aCoder.encode(amount, forKey: "amount")
        }
        if formatted != nil {
            aCoder.encode(formatted, forKey: "formatted")
        }
        if currency != nil {
            aCoder.encode(currency, forKey: "currency")
        }
    }
}
