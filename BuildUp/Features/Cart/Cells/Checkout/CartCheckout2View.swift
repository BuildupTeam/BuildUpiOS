//
//  CartCheckout2View.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

class CartCheckout2View: UIView {
    @IBOutlet private weak var checkoutButton: UIButton!
    @IBOutlet private weak var itemsCountLabel: UILabel!
    @IBOutlet private weak var subtotalLabel: UILabel!
    
    func initialize() {
        itemsCountLabel.font = .appFont(ofSize: 14, weight: .medium)
        subtotalLabel.font = .appFont(ofSize: 17, weight: .medium)
        checkoutButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        
        checkoutButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        checkoutButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        itemsCountLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        subtotalLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
    }
}
