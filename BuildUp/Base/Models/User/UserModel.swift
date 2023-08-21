//
//  UserModel.swift
//  flyers
//
//  Created by Mahmoud Nasser on 30/09/2022.
//

import Foundation
import ObjectMapper

enum Currencies: Int {
    case egp = 1
    case dollar = 2
}

// swiftlint:disable all
class UserModel: NSObject, NSCoding, Mappable {

    var apiToken: String?
    var accessToken: String?
    var profileId: Int?
    var referenceNo: String?
    var userIdentifier: String?
    var instagramAccountId: Int?
    var instagramShadowAccount: Int?
    var canCreateInstagramAd: Bool?
    var userName: String?
    var phone: String?
    var countryCode: String?
    var email: String?
    var wallet: Float?
    var promoCode: String?
//    var facebookPage: FacebookModel?
    var selectedCategory: CategoryModel?
    var currency: CurrencyModel?
//    var country: CountryModel?
    var isPageAssigned: Bool?
    var advertisingId: String?
    var appsflyerId: String?
    var isEmailVerified: Bool?
    
    override init() {
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        apiToken <- map["api_token"]
        apiToken <- map["apiToken"]
        accessToken <- map["accessToken"]
        profileId <- map["profile_id"]
        referenceNo <- map["referenceNo"]
        userIdentifier <- map["userIdentifier"]
        instagramAccountId <- map["instagram_account_id"]
        instagramShadowAccount <- map["instagram_shadow_account"]
        canCreateInstagramAd <- map["can_create_instagram_ad"]
        userName <- map["name"]
        phone <- map["phone"]
        countryCode <- map["country_code"]
        email <- map["email"]
        wallet <- map["wallet"]
        promoCode <- map["promoCode"]
        currency <- map["currency"]
//        country <- map["country"]
//        facebookPage <- map["facebookPage"]
        isPageAssigned <- map["is_page_assigned"]
        advertisingId <- map["advertising_id"]
        appsflyerId <- map["appsflyer_id"]
        isEmailVerified <- map["isEmailVerified"]
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        apiToken = aDecoder.decodeObject(forKey: "api_token") as? String
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        referenceNo = aDecoder.decodeObject(forKey: "referenceNo") as? String
        profileId = aDecoder.decodeObject(forKey: "profile_id") as? Int
        userIdentifier = aDecoder.decodeObject(forKey: "userIdentifier") as? String
        instagramAccountId = aDecoder.decodeObject(forKey: "instagram_account_id") as? Int
        instagramShadowAccount = aDecoder.decodeObject(forKey: "instagram_shadow_account") as? Int
        canCreateInstagramAd = aDecoder.decodeObject(forKey: "can_create_instagram_ad") as? Bool
        userName = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        countryCode = aDecoder.decodeObject(forKey: "country_code") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        currency = aDecoder.decodeObject(forKey: "currency") as? CurrencyModel
//        country = aDecoder.decodeObject(forKey: "country") as? CountryModel
        wallet = aDecoder.decodeObject(forKey: "wallet") as? Float
        promoCode = aDecoder.decodeObject(forKey: "promoCode") as? String
        selectedCategory = aDecoder.decodeObject(forKey: "selectedCategory") as? CategoryModel
        isPageAssigned = aDecoder.decodeObject(forKey: "is_page_assigned") as? Bool
        advertisingId = aDecoder.decodeObject(forKey: "advertising_id") as? String
        appsflyerId = aDecoder.decodeObject(forKey: "appsflyer_id") as? String
        isEmailVerified = aDecoder.decodeObject(forKey: "isEmailVerified") as? Bool
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if apiToken != nil {
            aCoder.encode(apiToken, forKey: "api_token")
        }
        if accessToken != nil {
            aCoder.encode(accessToken, forKey: "accessToken")
        }
        if profileId != nil {
            aCoder.encode(profileId, forKey: "profile_id")
        }
        if referenceNo != nil {
            aCoder.encode(referenceNo, forKey: "referenceNo")
        }
        if userIdentifier != nil {
            aCoder.encode(userIdentifier, forKey: "userIdentifier")
        }
        if instagramAccountId != nil {
            aCoder.encode(instagramAccountId, forKey: "instagram_account_id")
        }
        if instagramShadowAccount != nil {
            aCoder.encode(instagramShadowAccount, forKey: "instagram_shadow_account")
        }
        if canCreateInstagramAd != nil {
            aCoder.encode(canCreateInstagramAd, forKey: "can_create_instagram_ad")
        }
        if userName != nil {
            aCoder.encode(userName, forKey: "name")
        }
        if phone != nil {
            aCoder.encode(phone, forKey: "phone")
        }
        if countryCode != nil {
            aCoder.encode(countryCode, forKey: "country_code")
        }
        if email != nil {
            aCoder.encode(email, forKey: "email")
        }
        if wallet != nil {
            aCoder.encode(wallet, forKey: "wallet")
        }
        if promoCode != nil {
            aCoder.encode(promoCode, forKey: "promoCode")
        }
        if currency != nil {
            aCoder.encode(currency, forKey: "currency")
        }
//        if country != nil {
//            aCoder.encode(country, forKey: "country")
//        }
        if selectedCategory != nil {
            aCoder.encode(selectedCategory, forKey: "selectedCategory")
        }
        if isPageAssigned != nil {
            aCoder.encode(isPageAssigned, forKey: "is_page_assigned")
        }
        if advertisingId != nil {
            aCoder.encode(advertisingId, forKey: "advertising_id")
        }
        if appsflyerId != nil {
            aCoder.encode(appsflyerId, forKey: "appsflyer_id")
        }
        if isEmailVerified != nil {
            aCoder.encode(isEmailVerified, forKey: "isEmailVerified")
        }
    }
}
