//
//  RecommentedProductsType1CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import UIKit

class RecommentedProductsType1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
        
    @IBOutlet private weak var containerView: UIView!
        
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
        productNameLabel.font = .appFont(ofSize: 13, weight: .regular)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
    }
    
    func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name
            productOldPriceLabel.text = String(model.originalPrice ?? 0) + " SAR"
            productNewPriceLabel.text = String(model.currentPrice ?? 0) + " SAR"
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = Asset.icPlaceholderProduct.image
            }
        }
        
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
    }

}
