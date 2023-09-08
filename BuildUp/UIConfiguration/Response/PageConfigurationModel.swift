//
//  PageConfigurationModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class PageConfigurationModel: NSObject, NSCoding, Mappable {
    var page: String?
    var sections: [SectionConfigurationModel]?
    var settings: SettingsConfigurationModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        sections <- map["sections"]
        settings <- map["settings"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        page = aDecoder.decodeObject(forKey: "page") as? String
        sections = aDecoder.decodeObject(forKey: "sections") as? [SectionConfigurationModel]
        settings = aDecoder.decodeObject(forKey: "settings") as? SettingsConfigurationModel
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if page != nil {
            aCoder.encode(page, forKey: "page")
        }
        if sections != nil {
            aCoder.encode(sections, forKey: "sections")
        }
        if settings != nil {
            aCoder.encode(settings, forKey: "settings")
        }
    }
}
