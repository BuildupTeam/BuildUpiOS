//
//  AddToCartTextView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

protocol AddToCartDelegate: AnyObject {
    func productModelUpdated(_ model: ProductModel, _ homeSectionModel: HomeSectionModel?)
}

class AddToCartTextView: UIView {
    
    @IBOutlet private weak var counterContainerView: UIView!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    
    @IBOutlet private weak var plusImageView: UIImageView!
    @IBOutlet private weak var minusImageView: UIImageView!
    
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var countLabel: UILabel!
    
    weak var delegate: AddToCartDelegate?
    
    var productModel: ProductModel? {
        didSet {
            initialize()
        }
    }
    
    func initialize() {
        addToCartButton.titleLabel?.font = .appFont(ofSize: 13, weight: .semiBold)
        addToCartButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        addToCartButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        plusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
        minusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
        countLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
        
        countLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        
        if let model = productModel {
            if let quantity = model.cartQuantity, quantity > 0 {
                addToCartButton.hideView()
                counterContainerView.showView()
                countLabel.text = String(quantity)
            } else {
                addToCartButton.showView()
                counterContainerView.hideView()
            }
            
            checkIfCanMinusPlus(model: model)
        }
        
        minusButton.layer.borderWidth = 1
        minusButton.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
        
        ThemeManager.setCornerRadious(element: minusButton, radius: minusButton.frame.size.width / 2)
        ThemeManager.setCornerRadious(element: plusButton, radius: plusButton.frame.size.width / 2)
        ThemeManager.setCornerRadious(element: addToCartButton, radius: 15)
    }
    
    private func activateAddTocartButton() {
        DispatchQueue.main.async {
            self.addToCartButton.showView()
            self.counterContainerView.hideView()
        }
    }
    
    private func activateCounterView() {
        DispatchQueue.main.async {
            self.addToCartButton.hideView()
            self.counterContainerView.showView()
        }
    }
    
    private func addToCartFirebase(_ model: ProductModel) {
        let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.cartQuantity)
        RealTimeDatabaseService.addProductModel(model: firebaseProductModel)
    }
    
    private func removeFromCartFirebase(_ model: ProductModel) {
        let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.cartQuantity)
        RealTimeDatabaseService.removeProductModelFromCart(model: firebaseProductModel)
    }
    
    private func userLoggedIn() -> Bool {
        if CachingService.getUser() != nil {
            return true
        } else {
            return false
        }
    }
    
    private func checkIfCanMinusPlus(model: ProductModel) {
        if (model.cartQuantity ?? 0) >= (model.maxAddedQuantity ?? 0) {
            plusButton.isEnabled = false
            plusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor3?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor3 ?? "")
        } else {
            plusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
            plusButton.isEnabled = true
        }
        
        if (model.cartQuantity ?? 0) <= 1 {
            minusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor3?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor3 ?? "")
            minusButton.isEnabled = false
        } else {
            minusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
            minusButton.isEnabled = true
        }
    }
}

//MARK: - @IBAction
extension AddToCartTextView {
    @IBAction func addToCartButtonAction(_ sender: UIButton) {
        if CachingService.getUser() == nil {
            return
        }
        addToCartButton.hideView()
        counterContainerView.showView()
        
        if let model = self.productModel {
            addToCartFirebase(model)
        }
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        if let model = productModel {
            if var cartQuantity = model.cartQuantity {
                if (cartQuantity + 1 ) <= (model.maxAddedQuantity ?? 0) {
                    cartQuantity += 1
                    model.cartQuantity = cartQuantity
                }
            } else {
                model.cartQuantity = 1
            }
            
            self.productModel = model
            
            countLabel.text = String(model.cartQuantity ?? 0)
            addToCartFirebase(model)
            
            checkIfCanMinusPlus(model: model)
            delegate?.productModelUpdated(model, nil)
        }
    }
    
    @IBAction func minusButtonAction(_ sender: UIButton) {
        if let model = productModel {
            if var cartQuantity = model.cartQuantity {
                if (cartQuantity - 1 ) >= 1 {
                    cartQuantity -= 1
                    model.cartQuantity = cartQuantity
                    addToCartFirebase(model)
                    activateCounterView()
                } else {
                    removeFromCartFirebase(model)
                    activateAddTocartButton()
                }
            } else {
                removeFromCartFirebase(model)
                activateAddTocartButton()
            }
            
            self.productModel = model
            countLabel.text = String(model.cartQuantity ?? 0)
            
            checkIfCanMinusPlus(model: model)
            delegate?.productModelUpdated(model, nil)
        }
    }
}
