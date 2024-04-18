//
//  CheckoutPaymentMethodsTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/04/2024.
//

import UIKit

protocol CheckoutPaymentMethodsDelegate: AnyObject {
    func paymentMetyhodSelected(paymentMethod: PaymentMethodModel)
}

class CheckoutPaymentMethodsTableViewCell: UITableViewCell {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!

    weak var delegate: CheckoutPaymentMethodsDelegate?
    
    var paymentMethods: [PaymentMethodModel]? {
        didSet {
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
        
        containerView.setShadow(
            shadowRadius: CGFloat(8),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.9,
            cornerRadius: 8,
            masksToBounds: false)
        
        titleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        titleLabel.text = L10n.Checkout.paymentMethod

        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
    }
    
    private func registerTableViewCell() {
        self.tableView.register(
            UINib(nibName: CheckoutPaymentMethodTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutPaymentMethodTableViewCell.identifier)
    }
    
}

// MARK: - TableView Delegate && DataSource
extension CheckoutPaymentMethodsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentMethods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutPaymentMethodTableViewCell.identifier,
            for: indexPath) as? CheckoutPaymentMethodTableViewCell
        else { return UITableViewCell() }
        
        cell.paymentMethodModel = self.paymentMethods?[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let paymentMethods = self.paymentMethods {
            for address in paymentMethods {
                address.isSelected = false
            }
            
            if let model = self.paymentMethods?[indexPath.row] {
                model.isSelected = true
                self.paymentMethods?[indexPath.row] = model
                delegate?.paymentMetyhodSelected(paymentMethod: model)
                self.tableView.reloadData()
            }
        }
        
//        updateContinueButtonAppearence()
    }
}
