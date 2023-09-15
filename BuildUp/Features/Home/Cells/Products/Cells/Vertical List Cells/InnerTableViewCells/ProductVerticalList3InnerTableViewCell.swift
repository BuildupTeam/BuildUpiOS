//
//  ProductVerticalList3InnerTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/08/2023.
//

import UIKit

class ProductVerticalList3InnerTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productCountLabel: UILabel!
    
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var addToFavoriteButton: UIButton!
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var addToCartView: UIView!
    @IBOutlet private weak var addToFavoriteView: UIView!
    
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
        productNameLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productCountLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productCountLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
        
        addToFavoriteView.layer.masksToBounds = true
        addToFavoriteView.layer.cornerRadius = addToFavoriteView.frame.size.width / 2
        
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
        ThemeManager.setCornerRadious(element: addToFavoriteButton, radius: addToFavoriteButton.frame.width / 2)
    }
    
    private func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name ?? ""
            productOldPriceLabel.text = String(model.originalPrice ?? 0) + " SAR"
            productNewPriceLabel.text = String(model.currentPrice ?? 0) + " SAR"
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        addToCartButton.isHidden = true
        addToCartView.isHidden = false
    }
    
    @IBAction func addToFavoriteAction(_ sender: UIButton) {
        
    }
    
}
