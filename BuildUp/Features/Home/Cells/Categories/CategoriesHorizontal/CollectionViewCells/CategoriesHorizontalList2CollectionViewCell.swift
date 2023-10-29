//
//  CategoriesWithSelectedCollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesHorizontalList2CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var categoryImageContainerView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    var isCurved: Bool?
    
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
        categoryNameLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        categoryNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")

        categoryImageContainerView.layer.masksToBounds = true
        categoryImageContainerView.layer.cornerRadius = 8
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
//        ThemeManager.setCornerRadious(element: categoryImageContainerView, radius: 4)
        ThemeManager.setCornerRadious(element: categoryImageView, radius: 4)
    }
    
    func bindData() {
        if let model = categoryModel {
            categoryNameLabel.text = model.name
            
            if let imageUrl = model.image?.path {
                categoryImageView.setImage(with: imageUrl)
            } else {
                categoryImageView.image = UIImage() //Asset.icPlaceholderProduct.image
            }
        }
    }
}
