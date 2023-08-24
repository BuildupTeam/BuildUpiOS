//
//  ColorPaletteModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/08/2023.
//

import Foundation
import ObjectMapper

class ColorPaletteModel: NSObject, NSCoding, Mappable {
    var sectionTitleColor: String?
    var lightTextColor: String?
    var titleColor: String?
    var subtitleColor: String?
    var buttonColor1: String?
    var buttonTextColor1: String?
    var buttonIconColor1: String?
    var buttonColor2: String?
    var buttonTextColor2: String?
    var buttonIconColor2: String?
    var buttonColor3: String?
    var buttonTextColor3: String?
    var buttonIconColor3: String?
    var buttonColor4: String?
    var buttonIconColor4: String?
    var buttonTextColor4: String?
    var buttonBorderColor: String?
    var buttonBorderTextColor: String?
    var buttonBorderIconColor: String?
    var buttonBgBorderColor: String?
    var quantityCounterColor: String?
    var priceBefore: String?
    var priceAfter: String?
    var badgeColor: String?
    var badgeTextColor: String?
    var favouriteIconActive: String?
    var favouriteIconInactive: String?
    var favouriteBg: String?
    var backgroundedTitleColor: String?
    var backgroundedSubtitleColor: String?
    var titleSubtitleBgColor: String?
    var shadowColor: String?
    var tabsActiveBg: String?
    var tabsTextActive: String?
    var tabsInactiveBg: String?
    var tabsTextInactive: String?
    var tabsActiveBorder: String?
    var tabsInactiveBorder: String?
    var navButtonIconColor: String?
    var navButtonBgColor: String?
    var mainBg1: String?
    var mainBg2: String?
    var cardBg1: String?
    var cardBg2: String?
    var placeholderBg: String?
    var placeholderIcon: String?
    var separator: String?
    var indicatorActiveColor: String?
    var indicatorInactiveColor: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        sectionTitleColor <- map["section_title_color"]
        lightTextColor <- map["light_text_color"]
        titleColor <- map["title_color"]
        subtitleColor <- map["subtitle_color"]
        buttonColor1 <- map["button_color_1"]
        buttonTextColor1 <- map["button_text_color_1"]
        buttonIconColor1 <- map["button_icon_color_1"]
        buttonColor2 <- map["button_color_2"]
        buttonTextColor2 <- map["button_text_color_2"]
        buttonIconColor2 <- map["button_icon_color_2"]
        buttonColor3 <- map["button_color_3"]
        buttonTextColor3 <- map["button_text_color_3"]
        buttonIconColor3 <- map["button_icon_color_3"]
        buttonColor4 <- map["button_color_4"]
        buttonIconColor4 <- map["button_icon_color_4"]
        buttonTextColor4 <- map["button_text_color_4"]
        buttonBorderColor <- map["button_border_color"]
        buttonBorderTextColor <- map["button_border_text_color"]
        buttonBorderIconColor <- map["button_border_icon_color"]
        buttonBgBorderColor <- map["button_bg_border_color"]
        quantityCounterColor <- map["quantity_counter_color"]
        priceBefore <- map["price_before"]
        priceAfter <- map["price_after"]
        badgeColor <- map["badge_color"]
        badgeTextColor <- map["badge_text_color"]
        favouriteIconActive <- map["favourite_icon_active"]
        favouriteIconInactive <- map["favourite_icon_inactive"]
        favouriteBg <- map["favourite_bg"]
        backgroundedTitleColor <- map["backgrounded_title_color"]
        backgroundedSubtitleColor <- map["backgrounded_subtitle_color"]
        titleSubtitleBgColor <- map["title_subtitle_bg_color"]
        shadowColor <- map["shadow_color"]
        tabsActiveBg <- map["tabs_active_bg"]
        tabsTextActive <- map["tabs_text_active"]
        tabsInactiveBg <- map["tabs_inactive_bg"]
        tabsTextInactive <- map["tabs_text_inactive"]
        tabsActiveBorder <- map["tabs_active_border"]
        tabsInactiveBorder <- map["tabs_inactive_border"]
        navButtonIconColor <- map["nav_button_icon_color"]
        navButtonBgColor <- map["nav_button_bg_color"]
        mainBg1 <- map["main_bg_1"]
        mainBg2 <- map["main_bg_2"]
        cardBg1 <- map["card_bg_1"]
        cardBg2 <- map["card_bg_2"]
        placeholderBg <- map["placeholder_bg"]
        placeholderIcon <- map["placeholder_icon"]
        separator <- map["separator"]
        indicatorActiveColor <- map["indicator_active_color"]
        indicatorInactiveColor <- map["indicator_inactive_color"]

    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        sectionTitleColor = aDecoder.decodeObject(forKey: "sectionTitleColor") as? String
        lightTextColor = aDecoder.decodeObject(forKey: "lightTextColor") as? String
        titleColor = aDecoder.decodeObject(forKey: "titleColor") as? String
        subtitleColor = aDecoder.decodeObject(forKey: "subtitleColor") as? String
        buttonColor1 = aDecoder.decodeObject(forKey: "buttonColor1") as? String
        buttonTextColor1 = aDecoder.decodeObject(forKey: "buttonTextColor1") as? String
        buttonIconColor1 = aDecoder.decodeObject(forKey: "buttonIconColor1") as? String
        buttonColor2 = aDecoder.decodeObject(forKey: "buttonColor2") as? String
        buttonTextColor2 = aDecoder.decodeObject(forKey: "buttonTextColor2") as? String
        buttonIconColor2 = aDecoder.decodeObject(forKey: "buttonIconColor2") as? String
        buttonColor3 = aDecoder.decodeObject(forKey: "buttonColor3") as? String
        buttonTextColor3 = aDecoder.decodeObject(forKey: "buttonTextColor3") as? String
        buttonIconColor3 = aDecoder.decodeObject(forKey: "buttonIconColor3") as? String
        buttonColor4 = aDecoder.decodeObject(forKey: "buttonColor4") as? String
        buttonIconColor4 = aDecoder.decodeObject(forKey: "buttonIconColor4") as? String
        buttonTextColor4 = aDecoder.decodeObject(forKey: "buttonTextColor4") as? String
        buttonBorderColor = aDecoder.decodeObject(forKey: "buttonBorderColor") as? String
        buttonBorderTextColor = aDecoder.decodeObject(forKey: "buttonBorderTextColor") as? String
        buttonBorderIconColor = aDecoder.decodeObject(forKey: "buttonBorderIconColor") as? String
        buttonBgBorderColor = aDecoder.decodeObject(forKey: "buttonBgBorderColor") as? String
        quantityCounterColor = aDecoder.decodeObject(forKey: "quantityCounterColor") as? String
        priceBefore = aDecoder.decodeObject(forKey: "priceBefore") as? String
        priceAfter = aDecoder.decodeObject(forKey: "priceAfter") as? String
        badgeColor = aDecoder.decodeObject(forKey: "badgeColor") as? String
        badgeTextColor = aDecoder.decodeObject(forKey: "badgeTextColor") as? String
        favouriteIconActive = aDecoder.decodeObject(forKey: "favouriteIconActive") as? String
        favouriteIconInactive = aDecoder.decodeObject(forKey: "favouriteIconInactive") as? String
        favouriteBg = aDecoder.decodeObject(forKey: "favouriteBg") as? String
        backgroundedTitleColor = aDecoder.decodeObject(forKey: "backgroundedTitleColor") as? String
        backgroundedSubtitleColor = aDecoder.decodeObject(forKey: "backgroundedSubtitleColor") as? String
        titleSubtitleBgColor = aDecoder.decodeObject(forKey: "titleSubtitleBgColor") as? String
        shadowColor = aDecoder.decodeObject(forKey: "shadowColor") as? String
        tabsActiveBg = aDecoder.decodeObject(forKey: "tabsActiveBg") as? String
        tabsTextActive = aDecoder.decodeObject(forKey: "tabsTextActive") as? String
        tabsInactiveBg = aDecoder.decodeObject(forKey: "tabsInactiveBg") as? String
        tabsTextInactive = aDecoder.decodeObject(forKey: "tabsTextInactive") as? String
        tabsActiveBorder = aDecoder.decodeObject(forKey: "tabsActiveBorder") as? String
        tabsInactiveBorder = aDecoder.decodeObject(forKey: "tabsInactiveBorder") as? String
        navButtonIconColor = aDecoder.decodeObject(forKey: "navButtonIconColor") as? String
        navButtonBgColor = aDecoder.decodeObject(forKey: "navButtonBgColor") as? String
        mainBg1 = aDecoder.decodeObject(forKey: "mainBg1") as? String
        mainBg2 = aDecoder.decodeObject(forKey: "mainBg2") as? String
        cardBg1 = aDecoder.decodeObject(forKey: "cardBg1") as? String
        cardBg2 = aDecoder.decodeObject(forKey: "cardBg2") as? String
        placeholderBg = aDecoder.decodeObject(forKey: "placeholderBg") as? String
        placeholderIcon = aDecoder.decodeObject(forKey: "placeholderIcon") as? String
        separator = aDecoder.decodeObject(forKey: "separator") as? String
        indicatorActiveColor = aDecoder.decodeObject(forKey: "indicatorActiveColor") as? String
        indicatorInactiveColor = aDecoder.decodeObject(forKey: "indicatorInactiveColor") as? String
    }
    
    @objc
    func encode(with aCoder: NSCoder) {
        if sectionTitleColor != nil {
            aCoder.encode(sectionTitleColor, forKey: "sectionTitleColor")
        }
        if lightTextColor != nil {
            aCoder.encode(lightTextColor, forKey: "lightTextColor")
        }
        if titleColor != nil {
            aCoder.encode(titleColor, forKey: "titleColor")
        }
        if subtitleColor != nil {
            aCoder.encode(subtitleColor, forKey: "subtitleColor")
        }
        if buttonColor1 != nil {
            aCoder.encode(buttonColor1, forKey: "buttonColor1")
        }
        if buttonTextColor1 != nil {
            aCoder.encode(buttonTextColor1, forKey: "buttonTextColor1")
        }
        if buttonIconColor1 != nil {
            aCoder.encode(buttonIconColor1, forKey: "buttonIconColor1")
        }
        if buttonColor2 != nil {
            aCoder.encode(buttonColor2, forKey: "buttonColor2")
        }
        if buttonTextColor2 != nil {
            aCoder.encode(buttonTextColor2, forKey: "buttonTextColor2")
        }
        if buttonIconColor2 != nil {
            aCoder.encode(buttonIconColor2, forKey: "buttonIconColor2")
        }
        if buttonColor3 != nil {
            aCoder.encode(buttonColor3, forKey: "buttonColor3")
        }
        if buttonTextColor3 != nil {
            aCoder.encode(buttonTextColor3, forKey: "buttonTextColor3")
        }
        if buttonIconColor3 != nil {
            aCoder.encode(buttonIconColor3, forKey: "buttonIconColor3")
        }
        if buttonColor4 != nil {
            aCoder.encode(buttonColor4, forKey: "buttonColor4")
        }
        if buttonIconColor4 != nil {
            aCoder.encode(buttonIconColor4, forKey: "buttonIconColor4")
        }
        if buttonTextColor4 != nil {
            aCoder.encode(buttonTextColor4, forKey: "buttonTextColor4")
        }
        if buttonBorderColor != nil {
            aCoder.encode(buttonBorderColor, forKey: "buttonBorderColor")
        }
        if buttonBorderTextColor != nil {
            aCoder.encode(buttonBorderTextColor, forKey: "buttonBorderTextColor")
        }
        if buttonBorderIconColor != nil {
            aCoder.encode(buttonBorderIconColor, forKey: "buttonBorderIconColor")
        }
        if buttonBgBorderColor != nil {
            aCoder.encode(buttonBgBorderColor, forKey: "buttonBgBorderColor")
        }
        if quantityCounterColor != nil {
            aCoder.encode(quantityCounterColor, forKey: "quantityCounterColor")
        }
        if priceBefore != nil {
            aCoder.encode(priceBefore, forKey: "priceBefore")
        }
        if priceAfter != nil {
            aCoder.encode(priceAfter, forKey: "priceAfter")
        }
        if badgeColor != nil {
            aCoder.encode(badgeColor, forKey: "badgeColor")
        }
        if badgeTextColor != nil {
            aCoder.encode(badgeTextColor, forKey: "badgeTextColor")
        }
        if favouriteIconActive != nil {
            aCoder.encode(favouriteIconActive, forKey: "favouriteIconActive")
        }
        if favouriteIconInactive != nil {
            aCoder.encode(favouriteIconInactive, forKey: "favouriteIconInactive")
        }
        if favouriteBg != nil {
            aCoder.encode(favouriteBg, forKey: "favouriteBg")
        }
        if backgroundedTitleColor != nil {
            aCoder.encode(backgroundedTitleColor, forKey: "backgroundedTitleColor")
        }
        if backgroundedSubtitleColor != nil {
            aCoder.encode(backgroundedSubtitleColor, forKey: "backgroundedSubtitleColor")
        }
        if titleSubtitleBgColor != nil {
            aCoder.encode(titleSubtitleBgColor, forKey: "titleSubtitleBgColor")
        }
        if shadowColor != nil {
            aCoder.encode(shadowColor, forKey: "shadowColor")
        }
        if tabsActiveBg != nil {
            aCoder.encode(tabsActiveBg, forKey: "tabsActiveBg")
        }
        if tabsTextActive != nil {
            aCoder.encode(tabsTextActive, forKey: "tabsTextActive")
        }
        if tabsInactiveBg != nil {
            aCoder.encode(tabsInactiveBg, forKey: "tabsInactiveBg")
        }
        if tabsTextInactive != nil {
            aCoder.encode(tabsTextInactive, forKey: "tabsTextInactive")
        }
        if tabsActiveBorder != nil {
            aCoder.encode(tabsActiveBorder, forKey: "tabsActiveBorder")
        }
        if tabsInactiveBorder != nil {
            aCoder.encode(tabsInactiveBorder, forKey: "tabsInactiveBorder")
        }
        if navButtonIconColor != nil {
            aCoder.encode(navButtonIconColor, forKey: "navButtonIconColor")
        }
        if navButtonBgColor != nil {
            aCoder.encode(navButtonBgColor, forKey: "navButtonBgColor")
        }
        if mainBg1 != nil {
            aCoder.encode(mainBg1, forKey: "mainBg1")
        }
        if mainBg2 != nil {
            aCoder.encode(mainBg2, forKey: "mainBg2")
        }
        if cardBg1 != nil {
            aCoder.encode(cardBg1, forKey: "cardBg1")
        }
        if cardBg2 != nil {
            aCoder.encode(cardBg2, forKey: "cardBg2")
        }
        if placeholderBg != nil {
            aCoder.encode(placeholderBg, forKey: "placeholderBg")
        }
        if placeholderIcon != nil {
            aCoder.encode(placeholderIcon, forKey: "placeholderIcon")
        }
        if separator != nil {
            aCoder.encode(separator, forKey: "separator")
        }
        if indicatorActiveColor != nil {
            aCoder.encode(indicatorActiveColor, forKey: "indicatorActiveColor")
        }
        if indicatorInactiveColor != nil {
            aCoder.encode(indicatorInactiveColor, forKey: "indicatorInactiveColor")
        }
    }
}
