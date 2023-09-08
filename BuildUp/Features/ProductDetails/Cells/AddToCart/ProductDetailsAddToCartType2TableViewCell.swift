//
//  ProductDetailsAddToCartType2TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import UIKit

class ProductDetailsAddToCartType2TableViewCell: UITableViewCell {

    @IBOutlet private weak var quantityView: ProductDetailsQuantityDropDownView!
    @IBOutlet private weak var addToCartButton: UIButton!
            
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
        addToCartButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)

        quantityView.layer.masksToBounds = true
        quantityView.layer.cornerRadius = 4
        quantityView.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBg?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBg ?? "")

        addToCartButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        addToCartButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
    }
    
}
