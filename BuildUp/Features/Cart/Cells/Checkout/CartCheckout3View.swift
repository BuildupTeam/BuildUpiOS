//
//  CartCheckout3View.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

class CartCheckout3View: UIView {
    @IBOutlet private weak var checkoutButton: UIButton!
    
    func initialize() {
        checkoutButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        
        checkoutButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        checkoutButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
    }
}
