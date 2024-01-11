//
//  CheckoutPaymentMethodTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/12/2023.
//

import UIKit

class CheckoutPaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var paymentNameLabel: UILabel!
    @IBOutlet private weak var selectedPaymentView: UIView!
    @IBOutlet private weak var paymentImageView: UIImageView!

    var paymentMethodModel: PaymentMethodModel? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        paymentNameLabel.font = .appFont(ofSize: 13, weight: .medium)
        paymentNameLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        selectedPaymentView.layer.masksToBounds = true
        selectedPaymentView.layer.cornerRadius = selectedPaymentView.frame.size.width / 2
        selectedPaymentView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
    }
    
    private func bindData() {
        if let model = paymentMethodModel {
            if model.isSelected {
                selectedPaymentView.showView()
            } else {
                selectedPaymentView.hideView()
            }
            
            paymentNameLabel.text = model.name
            
            if let imageUrl = model.image {
                paymentImageView.setImage(with: imageUrl)
            } else {
                paymentImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
    
}
