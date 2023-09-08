//
//  ProductDetailsQuantityTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/09/2023.
//

import UIKit

class ProductDetailsQuantityCircleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var quantityTitleLabel: UILabel!
    @IBOutlet private weak var quantityView: ProductDetailsQuantityCircleView!
    @IBOutlet private weak var seperatorView: UIView!

    var productModel: ProductModel? {
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
        quantityTitleLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        quantityTitleLabel.textColor =  ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
    }
    
    private func bindData() {
        quantityView.productModel = productModel
    }
    
}
