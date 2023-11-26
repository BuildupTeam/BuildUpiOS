//
//  AddToCartIconView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

class AddToCartIconView: UIView {
    @IBOutlet private weak var counterContainerView: UIView!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var countLabel: UILabel!

    var productModel: ProductModel? {
        didSet {
            initialize()
        }
    }
    
    func initialize() {
        plusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
        minusButton.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        countLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
        
        countLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        
        if let quantity = productModel?.cartQuantity, quantity > 0 {
            addToCartButton.hideView()
            counterContainerView.showView()
            countLabel.text = String(quantity)
        } else {
            addToCartButton.showView()
            counterContainerView.hideView()
        }
        
        plusButton.layer.masksToBounds = true
        plusButton.layer.cornerRadius = plusButton.frame.size.width / 2
        
        minusButton.layer.masksToBounds = true
        minusButton.layer.cornerRadius = minusButton.frame.size.width / 2
        minusButton.layer.borderWidth = 1
        minusButton.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
        
        ThemeManager.setCornerRadious(element: addToCartButton, radius: 15)
    }
    
    @IBAction func addToCartButtonAction(_ sender: UIButton) {
        addToCartButton.hideView()
        counterContainerView.showView()
        addToCartFirebase()
    }
    
    private func addToCartFirebase() {
        if let model = productModel {
            let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.cartQuantity)
            RealTimeDatabaseService.addProductModel(model: firebaseProductModel)
        }
    }
    
    private func removeFromCartFirebase() {
        if let model = productModel {
            let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.cartQuantity)
            RealTimeDatabaseService.removeProductModelFromCart(model: firebaseProductModel)
        }
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        if let model = productModel {
            if var cartQuantity = model.cartQuantity {
                if (cartQuantity + 1 ) <= (model.maxAddedQuantity ?? 0) {
                    cartQuantity += 1
                }
            } else {
                model.cartQuantity = 1
            }
            
            countLabel.text = String(model.cartQuantity ?? 0)
            addToCartFirebase()
        }
    }
    
    @IBAction func minusButtonAction(_ sender: UIButton) {
        if let model = productModel {
            if var cartQuantity = model.cartQuantity {
                if (cartQuantity - 1 ) >= 1 {
                    cartQuantity -= 1
                    addToCartFirebase()
                    addToCartButton.hideView()
                    counterContainerView.showView()
                } else {
                    removeFromCartFirebase()
                    addToCartButton.showView()
                    counterContainerView.hideView()
                }
            }
            countLabel.text = String(model.cartQuantity ?? 0)
        }
    }
}