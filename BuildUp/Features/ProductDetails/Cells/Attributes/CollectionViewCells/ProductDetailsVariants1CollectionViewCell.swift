//
//  ProductDetailsAttributeType1CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import UIKit

class ProductDetailsVariants1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    var optionValueModel: ProductDetailsOptionValueModel? {
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
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 30 //containerView.frame.size.width / 2
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        titleLabel.font = .appFont(ofSize: 12, weight: .semiBold)
        
        titleLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
    }

    private func bindData() {
        if let model = optionValueModel {
            titleLabel.text = model.name
        }
    }
}
