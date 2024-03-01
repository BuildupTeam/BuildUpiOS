//
//  OrderDetailsSummaryTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import UIKit

class OrderDetailsSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderSummaryTitleLabel: UILabel!
    @IBOutlet weak var deliveryTitleLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var estimatedVatTitleLabel: UILabel!
    @IBOutlet weak var estimatedVatLabel: UILabel!
    @IBOutlet weak var subtotalTitleLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    var orderModel: OrderModel? {
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
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        orderSummaryTitleLabel.font = .appFont(ofSize: 15, weight: .semiBold)

        deliveryTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        deliveryLabel.font = .appFont(ofSize: 13.5, weight: .semiBold)
        
        subtotalTitleLabel.font = .appFont(ofSize: 14, weight: .medium)
        subtotalLabel.font = .appFont(ofSize: 13.5, weight: .medium)
                
        totalAmountTitleLabel.font = .appFont(ofSize: 16, weight: .bold)
        totalAmountLabel.font = .appFont(ofSize: 17.5, weight: .medium)

        orderSummaryTitleLabel .textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        deliveryTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        deliveryLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        subtotalTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        subtotalLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
                
        totalAmountTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        totalAmountLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        ThemeManager.setShadow(element: containerView,
                               shadowRadius: CGFloat(11),
                               xOffset: 0, yOffset: 0,
                               color: .black, opacity: 1,
                               cornerRadius: 8,
                               masksToBounds: false)
        
        totalAmountTitleLabel.text = L10n.Checkout.totalAmount
        orderSummaryTitleLabel.text = L10n.Checkout.orderSummery
        deliveryTitleLabel.text = L10n.Checkout.delivery
        subtotalTitleLabel.text = L10n.Checkout.subtotal
    }
    
    private func setupTableViewHeight() {
        if let taxDetails = orderModel?.orderTaxes, !taxDetails.isEmpty {
            tableViewHeightConstraint.constant = CGFloat(21 * (taxDetails.count))
        } else {
            tableViewHeightConstraint.constant = 0
        }
        
        containerViewHeightConstraint.constant = 116 + tableViewHeightConstraint.constant
//        topViewHeightConstraint.constant = 66 + tableViewHeightConstraint.constant
    }
    
    private func registerTableViewCell() {
        self.tableView.register(
            UINib(nibName: CheckoutTaxesTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutTaxesTableViewCell.identifier)
    }
    
    private func bindData() {
        if let model = orderModel {
            deliveryLabel.text = model.formattedTotalShippingCost?.formatted
            subtotalLabel.text = model.formattedSubtotal?.formatted
            totalAmountLabel.text = model.formattedTotal?.formatted
        }
    }
}

extension OrderDetailsSummaryTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderModel?.orderTaxes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutTaxesTableViewCell.identifier,
            for: indexPath) as? CheckoutTaxesTableViewCell
        else { return UITableViewCell() }
        
        if let model = self.orderModel?.orderTaxes?[indexPath.row] {
            cell.taxDetailsModel = model
        }

        cell.selectionStyle = .none
        return cell
    }
}
