//
//  ProductDetailsAttributeType3TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 31/08/2023.
//

import UIKit

class ProductDetailsVariants3TableViewCell: UITableViewCell {

    @IBOutlet private weak var variantValueLabel: UILabel!
    @IBOutlet private weak var variantNameLabel: UILabel!
    @IBOutlet private weak var variantActionButton: UIButton!
    @IBOutlet private weak var seperatorView: UIView!

    weak var delegate: ProductDetailsVarientSelectedDelegate?

    var combinationModel:  ProductDetailsCombinationsModel?
    var optionModel: ProductDetailsOptionsModel? {
        didSet {
            self.bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        variantValueLabel.textAlignment = .center
        variantValueLabel.font = .appFont(ofSize: 12, weight: .semiBold)
        variantNameLabel.font = .appFont(ofSize: 13, weight: .regular)
        
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
        variantValueLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
        variantNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
    }
    
    private func bindData() {
        if let model = optionModel {
            variantNameLabel.text = model.option?.name
            variantValueLabel.text = model.optionValues?.first?.name
            
            self.delegate?.optionValueSelected(model)
//            self.sizeToFit()
        }
    }
    
    @IBAction func variantButtonAction(_ sender: UIButton) {
        var elements: [UIAction] = []
        if let options = optionModel?.optionValues {
            for option in options {
                option.isSelected = false
                let element = UIAction(title: option.name ?? "", image: UIImage(), attributes: [], state: .off) { action in
                    print(option.name ?? "")
                    self.variantValueLabel.text = option.name
                    option.isSelected = true
                    if let model = self.optionModel {
                        self.delegate?.optionValueSelected(model)
                    }
                }
                elements.append(element)
            }
        }
        let menu = UIMenu(title: optionModel?.option?.name ?? "",identifier: .alignment, options: .displayInline, children: elements)
        variantActionButton.showsMenuAsPrimaryAction = true
        variantActionButton.menu = menu
    }
}
