//
//  UIButton+Extensions.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import UIKit

extension UIButton {
    func setupTabsButtonAppearance(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = .primaryColor
            self.setTitleColor(.white, for: .normal)
        } else {
            self.backgroundColor = .white
            self.setTitleColor(.dateColorGray, for: .normal)
        }
    }
}
