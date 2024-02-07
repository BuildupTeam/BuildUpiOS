//
//  CartSummeryTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

class CartSummeryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemsCountTitleLabel: UILabel!
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var savedTitleLabel: UILabel!
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var subtotalTitleLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    @IBOutlet private weak var stacKView: UIView!
    @IBOutlet private weak var itemsCountView: UIView!
    @IBOutlet private weak var savedView: UIView!
    @IBOutlet private weak var subtotalView: UIView!
    
    @IBOutlet private weak var containerViewHeightConstrains: NSLayoutConstraint!
    
    var cartModel: CartModel? {
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
        itemsCountTitleLabel.font = .appFont(ofSize: 13, weight: .regular)
        itemsCountLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        
        savedTitleLabel.font = .appFont(ofSize: 13, weight: .regular)
        savedLabel.font = .appFont(ofSize: 13, weight: .medium)
        
        subtotalTitleLabel.font = .appFont(ofSize: 13, weight: .medium)
        subtotalLabel.font = .appFont(ofSize: 17, weight: .medium)

        itemsCountTitleLabel.textColor = ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? "")
        itemsCountLabel.textColor = ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? "")
        
        savedTitleLabel.textColor = ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? "")
        savedLabel.textColor = ThemeManager.colorPalette?.favouriteIconActive?.toUIColor(hexa: ThemeManager.colorPalette?.favouriteIconActive ?? "")
        
        subtotalTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        subtotalLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        itemsCountTitleLabel.text = L10n.Cart.items
        savedTitleLabel.text = L10n.Cart.saved
        subtotalTitleLabel.text = L10n.Cart.subtotal
    }
    
    private func hideSavedPrice() {
        savedView.hideView()
        containerViewHeightConstrains.constant = 80
    }
    
    private func showSavedPrice() {
        savedView.showView()
        containerViewHeightConstrains.constant = 114
    }
    
    private func bindData() {
        if let model = cartModel {
            itemsCountLabel.text = String(model.products?.count ?? 0)
            
            let savedPrice = String(format: "%.2f", (model.subtotalBeforeDiscount?.amount ?? 0) - (model.formattedSubtotal?.amount ?? 0))
            if savedPrice == "0.00" {
                hideSavedPrice()
            } else {
                showSavedPrice()
                savedLabel.text = "-" + L10n.Cart.currency + String(savedPrice)
            }
            subtotalLabel.text = model.formattedSubtotal?.formatted
//            L10n.Cart.currency + String(format: "%.2f", (model.subtotal ?? 0))
        }
    }
    
}
