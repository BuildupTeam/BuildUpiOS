//
//  CustomerModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation
import ObjectMapper

class CustomerModel: NSObject, NSCoding, Mappable {
    
    var uuid: String?
    var fullName: String?
    var email: String?
    var phone: String?
    var countryCode: String?
    var emailVerified: Bool?
    var phoneVerified: Bool?
    
    override init() {
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        fullName <- map["full_name"]
        email <- map["email"]
        phone <- map["phone"]
        countryCode <- map["country_code"]
        emailVerified <- map["email_verified"]
        phoneVerified <- map["phone_verified"]

    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        uuid = aDecoder.decodeObject(forKey: "uuid") as? String
        fullName = aDecoder.decodeObject(forKey: "fullName") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        countryCode = aDecoder.decodeObject(forKey: "countryCode") as? String
        emailVerified = aDecoder.decodeObject(forKey: "emailVerified") as? Bool
        phoneVerified = aDecoder.decodeObject(forKey: "phoneVerified") as? Bool
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if uuid != nil {
            aCoder.encode(uuid, forKey: "uuid")
        }
        if fullName != nil {
            aCoder.encode(fullName, forKey: "fullName")
        }
        if email != nil {
            aCoder.encode(email, forKey: "email")
        }
        if phone != nil {
            aCoder.encode(phone, forKey: "phone")
        }
        if countryCode != nil {
            aCoder.encode(countryCode, forKey: "countryCode")
        }
        if emailVerified != nil {
            aCoder.encode(emailVerified, forKey: "emailVerified")
        }
        if phoneVerified != nil {
            aCoder.encode(phoneVerified, forKey: "phoneVerified")
        }
    }
}
