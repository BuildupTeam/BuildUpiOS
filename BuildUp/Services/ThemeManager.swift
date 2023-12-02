//
//  ThemeManager.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation
import UIKit

enum Theme: String {
    case light
}

class ThemeManager {
    
    static var colorPalette: ColorPaletteModel? {
        return CachingService.getThemeData()?.colorPalette
    }
    
    static func setCornerRadious(element: UIView, radius: CGFloat) {
        var isCurved = false
        if let themeData = CachingService.getThemeData() {
            if themeData.systemStyle == "curved" {
                isCurved = true
            }
        }
        
        if isCurved {
            element.layer.cornerRadius = radius
        } else {
            element.layer.cornerRadius = 0
        }
    }
    
    static func roundCorners(element: UIView, corners: UIRectCorner, radius: CGFloat) {
        var isCurved = false
        if let themeData = CachingService.getThemeData() {
            if themeData.systemStyle == "curved" {
                isCurved = true
            }
        }
        if !isCurved {
            return
        }
        
        let path = UIBezierPath(roundedRect: element.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        element.layer.mask = mask
    }
    
    static func setShadow(
        element: UIView,
        shadowRadius: CGFloat,
        xOffset: Int,
        yOffset: Int,
        color: UIColor,
        opacity: Float,
        cornerRadius: CGFloat,
        masksToBounds: Bool) {
            
            if let themeData = CachingService.getThemeData() {
                if themeData.systemStyle == "curved" {
                    element.layer.cornerRadius = cornerRadius
                } else {
                    element.layer.cornerRadius = 0
                }
            }
            
            element.layer.shadowColor = color.cgColor
//            element.layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
            element.layer.shadowPath = UIBezierPath(rect: element.bounds).cgPath
            element.layer.shadowRadius = shadowRadius
            element.layer.shadowOpacity = opacity
            element.layer.masksToBounds = masksToBounds
        }
    
    static func setImageViewShadow(
        element: UIView,
        shadowRadius: CGFloat,
        xOffset: Int,
        yOffset: Int,
        color: UIColor,
        opacity: Float,
        cornerRadius: CGFloat,
        masksToBounds: Bool) {
            var isCurved = false

            if let themeData = CachingService.getThemeData() {
                if themeData.systemStyle == "curved" {
                    isCurved = true
                    element.layer.cornerRadius = cornerRadius
                } else {
                    element.layer.cornerRadius = 0

                }
            }
            
            element.layer.shadowColor = color.cgColor
            element.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            element.layer.shadowPath = UIBezierPath(rect: element.bounds).cgPath
            element.layer.shouldRasterize = true
            element.layer.rasterizationScale = UIScreen.main.scale
            
            element.layer.shadowRadius = shadowRadius
            element.layer.shadowOpacity = opacity
            element.layer.masksToBounds = masksToBounds
        }
    
    static func setShadowWithoutMaskBounds(
        element: UIView,
        shadowRadius: CGFloat,
        xOffset: Int,
        yOffset: Int,
        color: UIColor,
        opacity: Float,
        cornerRadius: CGFloat,
        masksToBounds: Bool) {
            
            element.layer.cornerRadius = 0
            element.layer.shadowColor = color.cgColor
            element.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            // CGSize(width: xOffset, height: yOffset)
            element.layer.shadowPath = UIBezierPath(rect: element.bounds).cgPath
            element.layer.shouldRasterize = true
            element.layer.rasterizationScale = UIScreen.main.scale
            element.layer.shadowRadius = shadowRadius
            element.layer.shadowOpacity = opacity
            element.layer.masksToBounds = masksToBounds
        }
}

