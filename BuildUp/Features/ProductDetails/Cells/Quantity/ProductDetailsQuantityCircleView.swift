//
//  ProductDetailsQuantityView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/09/2023.
//

import UIKit

protocol ProductDetailsQuantityCircleViewDelegate: AnyObject {
    func plusButtonClicked()
    func minusButtonClicked()
}

class ProductDetailsQuantityCircleView: UIView {
    @IBOutlet private weak var plusContainerView: UIView!
    @IBOutlet private weak var minusContainerView: UIView!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var countLabel: UILabel!

    weak var delegate: ProductDetailsQuantityDelegate?

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
        
        if let model = productModel {
            if !(model.cartCombinations?.isEmpty ?? false) {
                if let combinationModel = model.selectedCombination {
                    if let quantityCombination = combinationModel.cartQuantity, quantityCombination > 0 {
                        countLabel.text = String(quantityCombination)
                    } else {
                        combinationModel.cartQuantity = 0
                        countLabel.text = String(combinationModel.cartQuantity ?? 0)
                    }
                }
            } else {
                if let quantity = model.cartQuantity, quantity > 0 {
                    countLabel.text = String(quantity)
                } else {
                    model.cartQuantity = 1
                    countLabel.text = String(model.cartQuantity ?? 0)
                }
            }
        }
        
        plusContainerView.layer.masksToBounds = true
        plusContainerView.layer.cornerRadius = minusContainerView.frame.size.width / 2
        
        minusContainerView.layer.masksToBounds = true
        minusContainerView.layer.cornerRadius = minusContainerView.frame.size.width / 2
        minusContainerView.layer.borderWidth = 1
        minusContainerView.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        if CachingService.getUser() == nil {
            return
        }
        if let model = productModel {
            if let combinationModel = model.cartCombinations?.first {
                if var cartQuantity = combinationModel.cartQuantity {
                    if (cartQuantity + 1 ) <= (combinationModel.quantity ?? 0) {
                        cartQuantity += 1
                        combinationModel.cartQuantity = cartQuantity
                    }
                } else {
                    combinationModel.cartQuantity = 1
                }
                
                countLabel.text = String(combinationModel.cartQuantity ?? 0)
                self.delegate?.qunatitySelected(quantity: combinationModel.cartQuantity ?? 0, model: model)
            } else {
                if var cartQuantity = model.cartQuantity {
                    if (cartQuantity + 1 ) <= (model.quantity ?? 0) {
                        cartQuantity += 1
                        model.cartQuantity = cartQuantity
                    }
                } else {
                    model.cartQuantity = 1
                }
                
                countLabel.text = String(model.cartQuantity ?? 0)
                self.delegate?.qunatitySelected(quantity: model.cartQuantity ?? 0, model: model)
            }
        }
    }
    
    @IBAction func minusButtonAction(_ sender: UIButton) {
        if let model = productModel {
            if var cartQuantity = model.cartQuantity {
                if (cartQuantity - 1 ) >= 1 {
                    cartQuantity -= 1
                    model.cartQuantity = cartQuantity
                } else {
                    // TODO: - show add to cart button
                }
            }
            
            countLabel.text = String(model.cartQuantity ?? 0)
            self.delegate?.qunatitySelected(quantity: model.cartQuantity ?? 0, model: model)
        }
    }
}
