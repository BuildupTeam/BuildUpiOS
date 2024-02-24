//
//  CheckoutTaxesTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 23/02/2024.
//

import UIKit

class CheckoutTaxesTableViewCell: UITableViewCell {

    @IBOutlet weak var estimatedVatTitleLabel: UILabel!
    @IBOutlet weak var estimatedVatLabel: UILabel!
    
    var taxDetailsModel: TaxDetailsModel? {
        didSet {
            bindData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        estimatedVatTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        estimatedVatLabel.font = .appFont(ofSize: 13, weight: .medium)
        
        estimatedVatTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        estimatedVatLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        estimatedVatTitleLabel.text = L10n.Checkout.estimatedVat
    }
    
    private func bindData() {
        if let model = taxDetailsModel {
            estimatedVatLabel.text = model.amount?.formatted
        }
    }
}
