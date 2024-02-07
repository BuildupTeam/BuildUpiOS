//
//  CheckoutPaymentTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class CheckoutPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var paymentMethodImageView: UIImageView!
    @IBOutlet private weak var paymentTitleLabel: UILabel!
    @IBOutlet private weak var onlinePaymentLabel: UILabel!
    
    var checkoutModel: CheckoutModel? {
        didSet {
            bindData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        paymentTitleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        onlinePaymentLabel.font = .appFont(ofSize: 13, weight: .medium)
        
        paymentTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        onlinePaymentLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        paymentTitleLabel.text = L10n.Checkout.payment
        onlinePaymentLabel.text = L10n.Checkout.cashOnDelivery
    }
    
    func bindData() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        if let model = checkoutModel {
            onlinePaymentLabel.text = model.paymentMethod?.name
            
            if let imageUrl = model.paymentMethod?.image {
                paymentMethodImageView.setImage(with: imageUrl)
            } else {
                paymentMethodImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
    
}
