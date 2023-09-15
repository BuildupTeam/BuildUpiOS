//
//  ProductVerticalGrid5CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/06/2023.
//

import UIKit

class ProductVerticalGrid5CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
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
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
        ThemeManager.roundCorners(element: productImageView, corners: [.topLeft, .topRight], radius: 8)
//        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
    }

    func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
}
