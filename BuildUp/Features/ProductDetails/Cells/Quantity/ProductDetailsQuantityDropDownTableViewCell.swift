//
//  ProductDetailsQuantityDropDownTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/09/2023.
//

import UIKit

class ProductDetailsQuantityDropDownTableViewCell: UITableViewCell {

    @IBOutlet private weak var quantityTitleLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var quantityActionButton: UIButton!
    @IBOutlet private weak var seperatorView: UIView!

    var actionMappings: [UIAction.Identifier: UIActionHandler] = [:]
    
//    private lazy var elements: [UIAction] = [first, second, third, fourth]
//    private lazy var menu = UIMenu(title: "new", children: elements)
    /*
     private lazy var first = UIAction(title: "first", image: UIImage(systemName: "pencil.circle"), attributes: [], state: .off) { action in
         print("first")
     }
     */
    
    var productModel: ProductModel? {
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
        quantityTitleLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        quantityLabel.font = .appFont(ofSize: 13, weight: .regular)
        
        quantityTitleLabel.textColor =  ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        quantityLabel.textColor =  ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
    }
    
    private func bindData() {
        
    }
    
    @IBAction func quantityButtonAction(_ sender: UIButton) {
        var elements: [UIAction] = []
        let quantityCount = productModel?.quantity ?? 0
                
        for i in (1 ..< 5) {
            let first = UIAction(title: String(i), image: UIImage(), attributes: [], state: .off) { action in
                print(String(i))
                self.productModel?.quantitySelected = i
                self.quantityLabel.text = String(i)
            }
            elements.append(first)
        }
        let menu = UIMenu(title: "Quantity",identifier: .alignment, options: .displayInline, children: elements)
        quantityActionButton.showsMenuAsPrimaryAction = true
        quantityActionButton.menu = menu
    }
}
