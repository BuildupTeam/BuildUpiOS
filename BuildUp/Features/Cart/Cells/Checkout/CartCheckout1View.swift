//
//  CartCheckout1View.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

protocol CartCheckoutDelegate: AnyObject {
    func checkoutButtonClicked()
}

class CartCheckout1View: UIView {
    @IBOutlet private weak var checkoutButton: UIButton!
    @IBOutlet private weak var subtotalTitleLabel: UILabel!
    @IBOutlet private weak var subtotalLabel: UILabel!
    
    weak var delegate: CartCheckoutDelegate?
    
    var cartModel: CartModel? {
        didSet {
            bindData()
        }
    }
    
    func initialize() {
        subtotalTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        subtotalLabel.font = .appFont(ofSize: 17, weight: .medium)
        checkoutButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        
        checkoutButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        checkoutButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        checkoutButton.setTitle(L10n.Cart.checkout, for: .normal)
        
        subtotalTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        subtotalLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        
        subtotalTitleLabel.text = L10n.Cart.subtotal
        
        ThemeManager.setCornerRadious(element: checkoutButton, radius: 8)
    }
    
    private func bindData() {
        if let model = cartModel {
            subtotalLabel.text = model.formattedTotal?.formatted //L10n.Cart.currency + String(subtotal)
            checkoutButton.setTitle("\(L10n.Cart.checkout) (\(model.products?.count ?? 0))", for: .normal)
        }
    }
    
    @IBAction func checkoutAction(_ sender: UIButton) {
        delegate?.checkoutButtonClicked()
    }
}
