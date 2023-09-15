//
//  LanguageModel.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import UIKit
import ObjectMapper

class LanguageModel: NSObject, NSCoding, Mappable {
    var name: String?
    var code: String? {
        didSet {
            appLanguageCode = LocalizationManager.getappLanguageCode(from: self.code)
            iosLanguageCode = LocalizationManager.getIosLanguageCode(from: self.code)
        }
    }
    var isSelected: Bool?
    var appLanguageCode: String = Language.arabic.rawValue
    var iosLanguageCode: String = Language.arabic.rawValue

    var semantic: UISemanticContentAttribute {
        switch code {
        case Language.arabic.rawValue:
            return .forceRightToLeft
        default:
            return .forceLeftToRight
        }
    }
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
//        self.isSelected = isSelected
        appLanguageCode = LocalizationManager.getappLanguageCode(from: self.code)
        iosLanguageCode = LocalizationManager.getIosLanguageCode(from: self.code)
    }
    
    override init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        code <- map["code"]
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        name = aDecoder.decodeObject(forKey: "name") as? String
        code = aDecoder.decodeObject(forKey: "code") as? String
        isSelected = aDecoder.decodeObject(forKey: "isSelected") as? Bool

        appLanguageCode = (aDecoder.decodeObject(forKey: "appLanguageCode") as? String) ?? Language.arabic.rawValue
        iosLanguageCode = (aDecoder.decodeObject(forKey: "iosLanguageCode") as? String) ?? Language.arabic.rawValue

    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if name != nil {
            aCoder.encode(name, forKey: "name")
        }
        if code != nil {
            aCoder.encode(code, forKey: "code")
        }

        aCoder.encode(isSelected, forKey: "isSelected")
        aCoder.encode(appLanguageCode, forKey: "appLanguageCode")
        aCoder.encode(iosLanguageCode, forKey: "iosLanguageCode")
    }
}
