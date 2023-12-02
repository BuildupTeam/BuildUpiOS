//
//  CategoryTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/11/2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var bottomSeparatorView: UIView!
    @IBOutlet private weak var categoryNameLabel: UILabel!

    var categoryModel: CategoryModel? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    private func setupView() {
        categoryNameLabel.font = .appFont(ofSize: 11, weight: .medium)
        categoryNameLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        bottomSeparatorView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
    }
    
    private func bindData() {
        if let model = self.categoryModel {
            if model.isSelected {
                categoryNameLabel.textColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "")

                separatorView.backgroundColor = ThemeManager.colorPalette?.tabsActiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsActiveBorder ?? "")
                containerView.backgroundColor = ThemeManager.colorPalette?.placeholderBg?.toUIColor(hexa: ThemeManager.colorPalette?.placeholderBg ?? "")

            } else {
                categoryNameLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")

                separatorView.backgroundColor = .clear
                containerView.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBg?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBg ?? "")
            }
            categoryNameLabel.text = self.categoryModel?.name
        }
    }
    
}
