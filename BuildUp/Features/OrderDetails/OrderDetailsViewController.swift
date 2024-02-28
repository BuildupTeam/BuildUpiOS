//
//  OrderDetailsViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import UIKit

enum OrderDetailsCells: Int {
    case status = 0
    case summary
    case payment
    case shipping
    case products
}

class OrderDetailsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var cancelOrderButton: UIButton!
    @IBOutlet private weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    var viewModel: OrderDetailsViewModel!
        
    override  var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: OrderDetailsViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupResponses()
        getOrderDetails()
    }
    
    @IBAction func cancelOrderAction(_ sender: UIButton) {
        let cancelOrderVC = CancelOrderPopupViewController()
        cancelOrderVC.delegate = self
        self.presentPanModal(cancelOrderVC)
    }

}

// MARK: - Private Func
extension OrderDetailsViewController {
    private func setupView() {
        cancelOrderButton.hideView()
        
        registerTableViewCells()
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        cancelOrderButton.setTitle(L10n.OrderDetails.cancelOrder, for: .normal)
        cancelOrderButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        cancelOrderButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        cancelOrderButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        ThemeManager.setCornerRadious(element: cancelOrderButton, radius: 8)
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: OrderDetailsPaymentTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: OrderDetailsPaymentTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: OrderDetailsShippingTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: OrderDetailsShippingTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: OrderDetailsProductsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: OrderDetailsProductsTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: OrderDetailsSummaryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: OrderDetailsSummaryTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: OrderDetailsStatusTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: OrderDetailsStatusTableViewCell.identifier)
    }
    
    private func getOrderDetails() {
        if self.viewModel.orderModel != nil {
            self.showLoading()
            self.viewModel.getOrderDetails()
        }
    }
    
    private func setupData() {
        self.title = L10n.OrderDetails.orderNumber + (self.viewModel.orderModel?.uuid ?? "")
        
        if let model = self.viewModel.orderModel {
            if model.status == OrderStatus.delivered.rawValue {
                tableViewBottomConstraint.constant = 0
                cancelOrderButton.hideView()
            } else {
                tableViewBottomConstraint.constant = 100
                cancelOrderButton.showView()
            }
        }
    }
    
    private func setupResponses() {
        orderDetailsResponse()
        cancelOrderResponse()
    }
    
    private func orderDetailsResponse() {
        self.viewModel.onOrderDetails = { [weak self]() in
            guard let `self` = self else { return }
            self.hideLoading()
            self.setupData()
            self.tableView.reloadData()
        }
    }
    
    private func cancelOrderResponse() {
        self.viewModel.onCancelOrder = { [weak self]() in
            guard let `self` = self else { return }
            self.hideLoading()
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: Get Cells
extension OrderDetailsViewController {
    private func getOrderStatusCell(model: OrderModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderDetailsStatusTableViewCell.identifier) as? OrderDetailsStatusTableViewCell
            else { return UITableViewCell() }
        
        cell.orderModel = model
        cell.selectionStyle = .none
        return cell
    }
    
    private func getPaymentCell(model: OrderModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderDetailsPaymentTableViewCell.identifier) as? OrderDetailsPaymentTableViewCell
            else { return UITableViewCell() }
        
        cell.orderModel = model
        cell.selectionStyle = .none
        return cell
    }
    
    private func getShippingCell(model: OrderModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderDetailsShippingTableViewCell.identifier) as? OrderDetailsShippingTableViewCell
        else { return UITableViewCell() }
        
        cell.orderModel = model
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductsCell(products: [ProductModel]?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderDetailsProductsTableViewCell.identifier) as? OrderDetailsProductsTableViewCell
        else { return UITableViewCell() }
        
        cell.products = products
        cell.selectionStyle = .none
        return cell
    }
    
    private func getSummaryCell(model: OrderModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderDetailsSummaryTableViewCell.identifier) as? OrderDetailsSummaryTableViewCell
        else { return UITableViewCell() }
        
        cell.orderModel = model
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Delegate && DataSource
extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let order = self.viewModel.orderModel else { return UITableViewCell() }
        
        switch indexPath.row {
        case OrderDetailsCells.status.rawValue:
            return getOrderStatusCell(model: order)
        case OrderDetailsCells.payment.rawValue:
            return getPaymentCell(model: order)
        case OrderDetailsCells.shipping.rawValue:
            return getShippingCell(model: order)
        case OrderDetailsCells.products.rawValue:
            return getProductsCell(products: order.products)
        case OrderDetailsCells.summary.rawValue:
            return getSummaryCell(model: order)
        default:
            return UITableViewCell()
        }
        
    }
}

extension OrderDetailsViewController: CancelOrderPopupProtocol {
    func cancelOrderClicked() {
        self.viewModel.cancelOrder()
    }
}
