//
//  UserModel.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import ObjectMapper

enum Currencies: Int {
    case egp = 1
    case dollar = 2
}

// swiftlint:disable all
class UserModel: NSObject, NSCoding, Mappable {

    var tokenType: String?
    var accessToken: String?
    var refreshToken: String?
    var customer: CustomerModel?
    
    override init() {
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        tokenType <- map["token_type"]
        accessToken <- map["access_token"]
        refreshToken <- map["refresh_token"]
        customer <- map["customer"]
        
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        tokenType = aDecoder.decodeObject(forKey: "tokenType") as? String
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        refreshToken = aDecoder.decodeObject(forKey: "refreshToken") as? String
        customer = aDecoder.decodeObject(forKey: "customer") as? CustomerModel
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if tokenType != nil {
            aCoder.encode(tokenType, forKey: "tokenType")
        }
        if accessToken != nil {
            aCoder.encode(accessToken, forKey: "accessToken")
        }
        if refreshToken != nil {
            aCoder.encode(refreshToken, forKey: "refreshToken")
        }
        if customer != nil {
            aCoder.encode(customer, forKey: "customer")
        }
    }
}
