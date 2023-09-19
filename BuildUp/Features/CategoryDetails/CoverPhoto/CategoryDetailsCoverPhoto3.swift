//
//  CategoryDetailsCoverPhoto3.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 17/09/2023.
//

import UIKit

class CategoryDetailsCoverPhoto3: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var categoryImageContainerView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var categoryModel: CategoryModel? {
        didSet {
            self.bindData()
        }
    }
    
    func initialize() {
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
//        ThemeManager.setCornerRadious(element: containerView, radius: 8)
//        ThemeManager.setCornerRadious(element: stackView, radius: 8)
        ThemeManager.roundCorners(element: categoryImageView, corners: [.topRight, .bottomRight], radius: 8)
        ThemeManager.roundCorners(element: categoryImageContainerView, corners: [.topRight, .bottomRight], radius: 8)
        ThemeManager.roundCorners(element: titleContainerView, corners: [.topLeft, .bottomLeft], radius: 8)
    }
    
    private func bindData() {
        if let model = categoryModel {
            if let imageUrl = model.image?.path {
                categoryImageView.setImage(with: imageUrl)
            } else {
                categoryImageView.image = UIImage() //Asset.icPlaceholderProduct.image
            }
        }
    }
}
