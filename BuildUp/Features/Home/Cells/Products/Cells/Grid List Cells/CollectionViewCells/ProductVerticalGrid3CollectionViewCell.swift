//
//  ProductVerticalGrid3CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalGrid3CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var addToCartImageView: UIImageView!

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productCountLabel: UILabel!
    
    @IBOutlet private weak var addToCartButton: UIButton!
    
    @IBOutlet private weak var addToCartView: UIView!
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
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
        productNameLabel.font = .appFont(ofSize: 13, weight: .regular)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        
        ThemeManager.setCornerRadious(element: productImageView, radius: 11)
        ThemeManager.setCornerRadious(element: addToCartView, radius: addToCartView.frame.width / 2)
        ThemeManager.setCornerRadious(element: containerView, radius: 11)
    }
    
    func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name ?? ""
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

}
