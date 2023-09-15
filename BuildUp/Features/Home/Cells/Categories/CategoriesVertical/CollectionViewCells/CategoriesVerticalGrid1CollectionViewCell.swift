//
//  CategoriesVerticalGrid4CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesVerticalGrid1CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var categoryNameContainerView: UIView!
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
        categoryNameLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        categoryNameLabel.textColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        categoryNameContainerView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
//        ThemeManager.roundCorners(element: containerView, corners: [.topLeft, .topRight], radius: 8)
        ThemeManager.roundCorners(element: categoryImageView, corners: [.topLeft, .topRight], radius: 8)
        ThemeManager.roundCorners(element: categoryNameContainerView, corners: [.bottomLeft, .bottomRight], radius: 8)
    }
    
    func bindData() {
        if let model = categoryModel {
            categoryNameLabel.text = model.name
            if let imageUrl = model.image?.path {
                categoryImageView.setImage(with: imageUrl)
            } else {
                categoryImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
    
}
