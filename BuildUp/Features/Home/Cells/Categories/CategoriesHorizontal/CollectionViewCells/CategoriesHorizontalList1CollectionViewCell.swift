//
//  CategoriesVerticalScrollingCollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesHorizontalList1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryNameLabel: UILabel!
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
        categoryNameLabel.font = .appFont(ofSize: 15, weight: .regular)
        categoryNameLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
        
        containerView.layer.borderWidth = 1
        
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
    }
    
    func bindData() {
        if let model = categoryModel {
            categoryNameLabel.text = model.name
            
            if model.isSelected {
                containerView.backgroundColor = ThemeManager.colorPalette?.tabsActiveBg?.toUIColor(hexa: ThemeManager.colorPalette?.tabsActiveBg ?? "")
                categoryNameLabel.textColor = ThemeManager.colorPalette?.tabsTextActive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextActive ?? "")
                containerView.layer.borderColor = ThemeManager.colorPalette?.tabsActiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsActiveBorder ?? "").cgColor
            } else {
                containerView.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBg?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBg ?? "")
                categoryNameLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
                containerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
            }
        }
    }

}
