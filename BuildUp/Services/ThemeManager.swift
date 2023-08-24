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
}

