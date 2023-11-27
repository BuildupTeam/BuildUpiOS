//
//  CheckoutProductCollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class CheckoutProductCollectionViewCell: UICollectionViewCell {

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
        productNameLabel.font = .appFont(ofSize: 13, weight: .semiBold)        
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
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
