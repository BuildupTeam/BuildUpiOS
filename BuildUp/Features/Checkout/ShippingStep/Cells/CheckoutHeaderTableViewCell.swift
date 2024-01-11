//
//  CheckoutHeaderTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import UIKit

class CheckoutHeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    var section: Int? {
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
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        titleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
    }
    
    private func bindData() {
        switch section {
        case 0:
            titleLabel.text = L10n.Checkout.contactInfo
        case 1:
            titleLabel.text = L10n.Checkout.deliveryInfo
        default:
            return
        }
    }
}
