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
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        sections <- map["sections"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        page = aDecoder.decodeObject(forKey: "page") as? String
        sections = aDecoder.decodeObject(forKey: "sections") as? [SectionConfigurationModel]
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if page != nil {
            aCoder.encode(page, forKey: "page")
        }
        if sections != nil {
            aCoder.encode(sections, forKey: "sections")
        }
    }
}
