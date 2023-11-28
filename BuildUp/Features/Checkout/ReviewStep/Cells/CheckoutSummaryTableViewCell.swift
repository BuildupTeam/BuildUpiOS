//
//  CheckoutSummaryTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class CheckoutSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderSummaryTitleLabel: UILabel!
    @IBOutlet weak var deliveryTitleLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var estimatedVatTitleLabel: UILabel!
    @IBOutlet weak var estimatedVatLabel: UILabel!
    @IBOutlet weak var subtotalTitleLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    var summaryModel: SummaryModel? {
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
        orderSummaryTitleLabel.font = .appFont(ofSize: 16, weight: .bold)

        deliveryTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        deliveryLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        
        subtotalTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        subtotalLabel.font = .appFont(ofSize: 13, weight: .medium)
        
        estimatedVatTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        estimatedVatLabel.font = .appFont(ofSize: 13, weight: .medium)

        orderSummaryTitleLabel .textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        deliveryTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        deliveryLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        subtotalTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        subtotalLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        estimatedVatTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        estimatedVatLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        orderSummaryTitleLabel.text = L10n.Checkout.orderSummery
        deliveryTitleLabel.text = L10n.Checkout.delivery
        estimatedVatTitleLabel.text = L10n.Checkout.estimatedVat
        subtotalTitleLabel.text = L10n.Checkout.subtotal
    }
    
    private func bindData() {
        if let model = summaryModel {
            deliveryLabel.text = L10n.Cart.currency + String(model.shippingDetails?.amount ?? 0)
            
            estimatedVatLabel.text = L10n.Cart.currency + String(model.taxes ?? 0.0)
            subtotalLabel.text = L10n.Cart.currency + String(model.subtotal ?? 0)
        }
    }
    
}
