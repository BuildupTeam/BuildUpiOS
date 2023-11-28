//
//  CheckoutPaymentTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class CheckoutPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var paymentTitleLabel: UILabel!
    @IBOutlet private weak var onlinePaymentLabel: UILabel!
    
    var checkoutModel: CheckoutModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        paymentTitleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        onlinePaymentLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        
        paymentTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        onlinePaymentLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        paymentTitleLabel.text = L10n.Checkout.payment
        onlinePaymentLabel.text = L10n.Checkout.onlinePayement
    }
    
}
