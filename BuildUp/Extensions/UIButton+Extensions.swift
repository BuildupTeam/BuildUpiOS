//
//  UIButton+Extensions.swift
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
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
