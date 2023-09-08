//
//  ProductDetailsQuantityView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/09/2023.
//

import UIKit

class ProductDetailsQuantityCircleView: UIView {
    @IBOutlet private weak var plusContainerView: UIView!
    @IBOutlet private weak var minusContainerView: UIView!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var countLabel: UILabel!

    var productModel: ProductModel? {
        didSet {
            initialize()
        }
    }
    
    func initialize() {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
            if settings.quantityPosition == ProductDetailsQuantityPosition.upper.rawValue {
                plusContainerView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
                
            } else {
                plusContainerView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
            }
        }
        
        minusContainerView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        countLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
        
        countLabel.font = .appFont(ofSize: 17, weight: .semiBold)
        
        plusContainerView.layer.masksToBounds = true
        plusContainerView.layer.cornerRadius = minusContainerView.frame.size.width / 2
        
        minusContainerView.layer.masksToBounds = true
        minusContainerView.layer.cornerRadius = minusContainerView.frame.size.width / 2
        minusContainerView.layer.borderWidth = 1
        minusContainerView.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
    }
    
}
