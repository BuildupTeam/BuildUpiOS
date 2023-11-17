//
//  AddToCartTextView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

class AddToCartTextView: UIView {
    
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
        addToCartButton.titleLabel?.font = .appFont(ofSize: 13, weight: .semiBold)
        addToCartButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        addToCartButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        plusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
        minusButton.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        countLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
        
        countLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        
        if let model = productModel {
            countLabel.text = String(model.quantitySelected)
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
        addToCartButton.isHidden = true
        counterContainerView.isHidden = false
        addToCartFirebase()
    }
    
    private func addToCartFirebase() {
        if let model = productModel {
            let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.quantitySelected)
            RealTimeDatabaseService.addProductModel(model: firebaseProductModel)
        }
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        if (productModel?.quantitySelected ?? 0) >= 1 {
            
            if ((productModel?.quantitySelected ?? 0) + 1 ) <= (productModel?.maxAddedQuantity ?? 0) {
                productModel?.quantitySelected += 1
            }
        }
        
        countLabel.text = String(productModel?.quantitySelected ?? 0)
        addToCartFirebase()
    }
    
    @IBAction func minusButtonAction(_ sender: UIButton) {
        if (productModel?.quantitySelected ?? 0) > 1 {
            productModel?.quantitySelected -= 1
        }
        
        countLabel.text = String(productModel?.quantitySelected ?? 0)
        addToCartFirebase()
    }
}
