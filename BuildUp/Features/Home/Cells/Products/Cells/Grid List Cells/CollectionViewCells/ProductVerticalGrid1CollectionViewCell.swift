//
//  ProductVerticalGrid1CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalGrid1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var addToFavoriteImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var addToFavoriteButton: UIButton!

    @IBOutlet private weak var addToFavoriteView: UIView!
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
        productNameLabel.font = .appFont(ofSize: 14, weight: .bold)
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
        ThemeManager.setCornerRadious(element: addToFavoriteView, radius: 8)
    }
    
    func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = Asset.icPlaceholderProduct.image
            }
        }
        
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
    }
    
    @IBAction func addToFavoriteAction(_ sender: UIButton) {
         
    }

}
