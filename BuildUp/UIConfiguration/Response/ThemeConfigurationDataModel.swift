//
//  ThemeConfigurationDataModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import ObjectMapper

class ThemeConfigurationDataModel: NSObject, NSCoding, Mappable {
    var id: Int?
    var font: String?
    var colorPalette: ColorPaletteModel?
    var systemStyle: String?
    var pages: [PageConfigurationModel]?
    var appCountryId: AppCountryIdModel?
    var currency: String?
    var iOSAppIcon: iOSAppIconModel?
    var projectLogo: iOSAppIconModel?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        font <- map["font"]
        colorPalette <- map["color_palette"]
        systemStyle <- map["system_style"]
        pages <- map["pages"]
        appCountryId <- map["app_country_id"]
        currency <- map["currency"]
        iOSAppIcon <- map["ios_app_icon"]
        projectLogo <- map["project_logo"]
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        font = aDecoder.decodeObject(forKey: "font") as? String
        colorPalette = aDecoder.decodeObject(forKey: "colorPalette") as? ColorPaletteModel
        systemStyle = aDecoder.decodeObject(forKey: "systemStyle") as? String
        pages = aDecoder.decodeObject(forKey: "pages") as? [PageConfigurationModel]
        appCountryId = aDecoder.decodeObject(forKey: "appCountryId") as? AppCountryIdModel
        currency = aDecoder.decodeObject(forKey: "currency") as? String
        iOSAppIcon = aDecoder.decodeObject(forKey: "iOSAppIcon") as? iOSAppIconModel
        projectLogo = aDecoder.decodeObject(forKey: "projectLogo") as? iOSAppIconModel
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if font != nil {
            aCoder.encode(font, forKey: "font")
        }
        if colorPalette != nil {
            aCoder.encode(colorPalette, forKey: "colorPalette")
        }
        if systemStyle != nil {
            aCoder.encode(systemStyle, forKey: "systemStyle")
        }
        if pages != nil {
            aCoder.encode(pages, forKey: "pages")
        }
        if appCountryId != nil {
            aCoder.encode(appCountryId, forKey: "appCountryId")
        }
        if currency != nil {
            aCoder.encode(currency, forKey: "currency")
        }
        if iOSAppIcon != nil {
            aCoder.encode(iOSAppIcon, forKey: "iOSAppIcon")
        }
        if projectLogo != nil {
            aCoder.encode(projectLogo, forKey: "projectLogo")
        }
    }
}
