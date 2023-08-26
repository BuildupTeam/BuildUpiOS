//
//  CategoriesVerticalGrid9CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesVerticalGrid3CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    
    var categoryModel: CategoryModel? {
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
    }
    
    func bindData() {
        if let model = categoryModel {
            if let imageUrl = model.image?.path {
                categoryImageView.setImage(with: imageUrl)
            } else {
                categoryImageView.image = Asset.icPlaceholderProduct.image
            }
        }
    }
}
