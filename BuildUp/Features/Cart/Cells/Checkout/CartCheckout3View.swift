//
//  CartCheckout3View.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

class CartCheckout3View: UIView {
    @IBOutlet private weak var checkoutButton: UIButton!
    
    var cartModel: CartModel? {
        didSet {
            bindData()
        }
    }
    
    func initialize() {
        checkoutButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        
        checkoutButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        checkoutButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        checkoutButton.setTitle(L10n.Cart.checkout, for: .normal)
        
        ThemeManager.setCornerRadious(element: checkoutButton, radius: 8)
    }
    
    private func bindData() {
        if let model = cartModel {
            checkoutButton.setTitle("\(L10n.Cart.checkout)(\(L10n.Cart.currency + String(model.subtotal ?? 0)))", for: .normal)
        }
    }
}
