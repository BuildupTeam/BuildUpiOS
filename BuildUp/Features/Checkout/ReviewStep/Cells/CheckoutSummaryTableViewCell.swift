//
//  CheckoutSummaryTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class CheckoutSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderSummaryTitleLabel: UILabel!
    @IBOutlet weak var deliveryTitleLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var estimatedVatTitleLabel: UILabel!
    @IBOutlet weak var estimatedVatLabel: UILabel!
    @IBOutlet weak var subtotalTitleLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    var summaryModel: SummaryModel? {
        didSet {
            bindData()
            setupTableViewHeight()
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
        
        orderSummaryTitleLabel.font = .appFont(ofSize: 16, weight: .bold)

        deliveryTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        deliveryLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        
        subtotalTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        subtotalLabel.font = .appFont(ofSize: 13, weight: .medium)
        
//        estimatedVatTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
//        estimatedVatLabel.font = .appFont(ofSize: 13, weight: .medium)

        orderSummaryTitleLabel .textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        deliveryTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        deliveryLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        subtotalTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        subtotalLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
//        estimatedVatTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
//        estimatedVatLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        orderSummaryTitleLabel.text = L10n.Checkout.orderSummery
        deliveryTitleLabel.text = L10n.Checkout.delivery
//        estimatedVatTitleLabel.text = L10n.Checkout.estimatedVat
        subtotalTitleLabel.text = L10n.Checkout.subtotal
    }
    
    private func bindData() {
        if let model = summaryModel {
            deliveryLabel.text = model.shippingDetails?.amount?.formatted
//            estimatedVatLabel.text = model.formattedTaxes?.formatted
            subtotalLabel.text = model.formattedSubtotal?.formatted
        }
    }
    
    private func setupTableViewHeight() {
        if let taxDetails = summaryModel?.taxDetails, !taxDetails.isEmpty {
            tableViewHeightConstraint.constant = CGFloat(21 * (taxDetails.count))
        } else {
            tableViewHeightConstraint.constant = 21
        }
        
        containerViewHeightConstraint.constant = 130 + tableViewHeightConstraint.constant
    }
    
    private func registerTableViewCell() {
        self.tableView.register(
            UINib(nibName: CheckoutTaxesTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutTaxesTableViewCell.identifier)
    }
    
}

extension CheckoutSummaryTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryModel?.taxDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutTaxesTableViewCell.identifier,
            for: indexPath) as? CheckoutTaxesTableViewCell
        else { return UITableViewCell() }
        
        if let model = self.summaryModel?.taxDetails?[indexPath.row] {
            cell.taxDetailsModel = model
        }

        cell.selectionStyle = .none
        return cell
    }
}
