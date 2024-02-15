//
//  OrderDetailsPaymentTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import UIKit

class OrderDetailsPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var paymentImageView: UIImageView!
    @IBOutlet private weak var paymentTitleLabel: UILabel!
    @IBOutlet private weak var onlinePaymentLabel: UILabel!
    
    var orderModel: OrderModel? {
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
//        onlinePaymentLabel.text = L10n.Checkout.cashOnDelivery
        
        ThemeManager.setShadow(element: containerView,
                               shadowRadius: CGFloat(11),
                               xOffset: 0, yOffset: 0,
                               color: .black, opacity: 1,
                               cornerRadius: 8,
                               masksToBounds: false)
    }
    
    private func bindData() {
        if let model = orderModel {
            onlinePaymentLabel.text = model.paymentMethod
            
            if let imageUrl = model.paymentMethodImage {
                paymentImageView.setImage(with: imageUrl)
            } else {
                paymentImageView.image = UIImage()
            }
        }
    }
}
