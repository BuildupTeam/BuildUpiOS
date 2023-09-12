//
//  ProductVerticalGrid4CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/06/2023.
//

import UIKit

class ProductVerticalGrid4CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
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
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
    }

    func bindData() {
        if let model = productModel {
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = Asset.icPlaceholderProduct.image
            }
        }
    }
}
