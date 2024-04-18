//
//  CheckoutProductsListTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 03/04/2024.
//

import UIKit

class CheckoutProductsListTableViewCell: UITableViewCell {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!

    var products: [ProductModel]? {
        didSet {
            self.bindData()
            self.tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCell()
        
        titleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")

        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        containerView.setShadow(
            shadowRadius: CGFloat(8),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.9,
            cornerRadius: 8,
            masksToBounds: false)
        
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
    }
    
    private func registerTableViewCell() {
        self.tableView.register(
            UINib(nibName: CheckoutProductInnerTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutProductInnerTableViewCell.identifier)
    }
    
    private func bindData() {
        let stringValue = L10n.Checkout.items + " (\(String(self.products?.count ?? 0)) \(L10n.Checkout.items))"

        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColorFontForText(textForAttribute: L10n.Checkout.items, withColor: ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "") ?? UIColor.gray, withFont: .appFont(ofSize: 15, weight: .semiBold))
        attributedString.setColorFontForText(textForAttribute: " (\(String(self.products?.count ?? 0)) \(L10n.Checkout.items))", withColor: ThemeManager.colorPalette?.badgeColor?.toUIColor(hexa: ThemeManager.colorPalette?.badgeColor ?? "") ?? UIColor.gray, withFont: .appFont(ofSize: 14, weight: .medium))
        
        titleLabel.attributedText = attributedString
    }
    
}

extension CheckoutProductsListTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutProductInnerTableViewCell.identifier,
            for: indexPath) as? CheckoutProductInnerTableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = self.products?[indexPath.row]
                
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
