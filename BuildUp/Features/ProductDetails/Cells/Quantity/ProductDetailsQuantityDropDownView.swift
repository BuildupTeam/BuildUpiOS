//
//  ProductDetailsQuantityDropDownView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/09/2023.
//

import UIKit

class ProductDetailsQuantityDropDownView: UIView {
    @IBOutlet private weak var quantityTitleLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var quantityActionButton: UIButton!

    var productModel: ProductModel? {
        didSet {
            initialize()
        }
    }
    
    private func initialize() {
        quantityTitleLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
        quantityLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
        
        quantityTitleLabel.font = .appFont(ofSize: 15, weight: .regular)
        quantityLabel.font = .appFont(ofSize: 15, weight: .regular)
    }
}
