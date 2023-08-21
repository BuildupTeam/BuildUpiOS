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
    static func setCornerRadious(element: UIView, radius: CGFloat) {
        var isCurved = false //from cache
        
        if isCurved {
            element.layer.cornerRadius = radius
        } else {
            element.layer.cornerRadius = 0
        }
    }
}
