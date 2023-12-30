//
//  ProductDetailsQuantityDropDownView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/09/2023.
//

import UIKit

protocol ProductDetailsQuantityDelegate: AnyObject {
    func qunatitySelected(quantity: Int, model: ProductModel)
}

class ProductDetailsQuantityDropDownView: UIView {
    @IBOutlet private weak var quantityTitleLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var quantityActionButton: UIButton!

    weak var delegate: ProductDetailsQuantityDelegate?
    
    var menu: UIMenu?
    
    var productModel: ProductModel? {
        didSet {
            initialize()
        }
    }
    
    private func initialize() {
        quantityTitleLabel.text = L10n.ProductDetails.quantityShort
        quantityTitleLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
        quantityLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
        
        quantityTitleLabel.font = .appFont(ofSize: 15, weight: .regular)
        quantityLabel.font = .appFont(ofSize: 15, weight: .regular)
        
        menu = UIMenu(title: L10n.ProductDetails.quantity, identifier: .alignment, options: .displayInline, children: [])
        quantityActionButton.menu = menu
        checkToShowMenu()
        
        if let model = productModel {
            if let combinationModel = model.cartCombinations?.first {
                quantityLabel.text = String(combinationModel.cartQuantity ?? 0)
            } else {
                quantityLabel.text = String(model.cartQuantity ?? 0)
            }
        }
    }
    
    @IBAction func quantityActionButton(_ sender: UIButton) {
        quantityActionButton.showsMenuAsPrimaryAction = true
        quantityActionButton.menu = menu
    }
    
    func checkToShowMenu() {
        var elements: [UIAction] = []
        guard let model = productModel else { return }
        let quantityCount = model.getMaxQuantity()
                
        if quantityCount <= 1 {
            return
        }
        
        for i in (1 ... quantityCount) {
            let first = UIAction(title: String(i), image: UIImage(), attributes: [], state: .off) { action in
                print(String(i))
                if (model.cartCombinations?.first) != nil {
                    model.cartCombinations?.first?.cartQuantity = i
                } else {
                    model.cartQuantity = i
                }
                
                self.quantityLabel.text = String(i)
                self.delegate?.qunatitySelected(quantity: i, model: model)
            }
            elements.append(first)
        }
        
        menu = menu?.replacingChildren(elements)
        quantityActionButton.showsMenuAsPrimaryAction = false
    }
}
