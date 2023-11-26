//
//  ProductVerticalList1InnerTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/08/2023.
//

import UIKit

class ProductVerticalList1InnerTableViewCell: UITableViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
        
    @IBOutlet private weak var addToCartView: AddToCartTextView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productOldPriceMarkedView: UIView!

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
//        addToCartView.initialize()
        
        productNameLabel.font = .appFont(ofSize: 13, weight: .bold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)

        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
        ThemeManager.setCornerRadious(element: addToCartView, radius: 8)
    }
    
    private func bindData() {
        if let model = productModel {
            if model.hasCombinations ?? false {
                addToCartView.isHidden = true
            } else {
                addToCartView.isHidden = false
                addToCartView.productModel = model
            }
            
            productNameLabel.text = model.name ?? ""
            productOldPriceLabel.text = String(model.originalPrice ?? 0) + L10n.ProductDetails.currency
            productNewPriceLabel.text = String(model.currentPrice ?? 0) + L10n.ProductDetails.currency
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
            
            if (model.discount ?? 0) > 0 {
                productOldPriceLabel.isHidden = false
                productOldPriceMarkedView.isHidden = false
            } else {
                productOldPriceLabel.isHidden = true
                productOldPriceMarkedView.isHidden = true
            }
        }
    }
    
}
