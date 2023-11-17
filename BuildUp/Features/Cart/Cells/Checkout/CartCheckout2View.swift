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
    
    var cartModel: CartModel? {
        didSet {
            bindData()
        }
    }
    
    func initialize() {
        itemsCountLabel.font = .appFont(ofSize: 14, weight: .medium)
        subtotalLabel.font = .appFont(ofSize: 17, weight: .medium)
        checkoutButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        
        itemsCountLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        subtotalLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        
        ThemeManager.setCornerRadious(element: checkoutButton, radius: 8)
        
        checkoutButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        checkoutButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        checkoutButton.setTitle(L10n.Cart.checkout, for: .normal)
    }
        
    private func bindData() {
        if let model = cartModel {
            subtotalLabel.text = L10n.Cart.currency + String(model.subtotal ?? 0)
            itemsCountLabel.text = L10n.Cart.items + String(model.products?.count ?? 0)
        }
    }
}
