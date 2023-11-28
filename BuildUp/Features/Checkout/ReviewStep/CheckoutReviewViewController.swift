//
//  CheckoutReviewViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit

enum CheckoutReviewCells: Int {
    case payment = 0
    case shipping
    case products
    case summary
}

class CheckoutReviewViewController: BaseViewController {

    @IBOutlet private weak var headerView: CheckoutStatusView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var checkoutContainerView: UIView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var subtotalTitleLabel: UILabel!
    @IBOutlet weak var checkoutContainerHeightConstraint: NSLayoutConstraint!

    @IBOutlet private weak var checkoutButton: UIButton!

    var viewModel: CheckoutReviewViewModel!
    
    var checkoutModel: CheckoutModel?
    
    override  var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: CheckoutReviewViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setupView()
        setupResponse()
        getSummary()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = L10n.Checkout.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
}

// MARK: - Private Func
extension CheckoutReviewViewController {
    private func setupView() {
        headerView.setupView()
        headerView.setupReviewView()
        
        checkoutContainerHeightConstraint.constant = 0
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        subtotalTitleLabel.text = L10n.Checkout.totalAmount
        subtotalTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        subtotalLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        subtotalTitleLabel.font = .appFont(ofSize: 17, weight: .medium)
        subtotalLabel.font = .appFont(ofSize: 16, weight: .bold)
        
        checkoutButton.layer.masksToBounds = true
        checkoutButton.layer.cornerRadius = 8
        checkoutButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        checkoutButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        checkoutButton.setTitle(L10n.Checkout.continue, for: .normal)
        checkoutButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: CheckoutPaymentTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutPaymentTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutShippingTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutShippingTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutProductsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutProductsTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutSummaryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutSummaryTableViewCell.identifier)
    }
    
    private func getSummary() {
        if let model = checkoutModel {
            self.showLoading()
            self.viewModel.getSummary(model.address?.id ?? 0)
        }
    }
    
    private func setupTotalPrice() {
        checkoutContainerHeightConstraint.constant = 137
        checkoutContainerView.showView()
        if let summary = self.viewModel.summaryData?.summary {
            subtotalLabel.text = (summary.formattedSubtotal?.formatted ?? "")
            //String(summary.formattedSubtotal?.formatted) + L10n.ProductDetails.currency
        }
    }
    
    private func setupResponse() {
        self.viewModel.onSummary = { [weak self]() in
            guard let `self` = self else { return }
            self.hideLoading()
            setupTotalPrice()
            self.tableView.reloadData()
        }
    }
}

// MARK: Actions
extension CheckoutReviewViewController {
    @IBAction func checkoutAction(_ sender: UIButton) {
//        self.showLoading()
        
    }
}

// MARK: Get Cells
extension CheckoutReviewViewController {
    private func getPaymentCell(model: CheckoutModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutPaymentTableViewCell.identifier) as? CheckoutPaymentTableViewCell
            else { return UITableViewCell() }
        
        cell.checkoutModel = model
        cell.selectionStyle = .none
        return cell
    }
    
    private func getShippingCell(model: CheckoutModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutShippingTableViewCell.identifier) as? CheckoutShippingTableViewCell
        else { return UITableViewCell() }
        
        cell.checkoutModel = model
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductsCell(products: [ProductModel]?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutProductsTableViewCell.identifier) as? CheckoutProductsTableViewCell
        else { return UITableViewCell() }
        
        cell.products = products
        cell.selectionStyle = .none
        return cell
    }
    
    private func getSummaryCell(summary: SummaryModel?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutSummaryTableViewCell.identifier) as? CheckoutSummaryTableViewCell
        else { return UITableViewCell() }
        
        cell.summaryModel = summary
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Delegate && DataSource
extension CheckoutReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case CheckoutReviewCells.payment.rawValue:
            return getPaymentCell(model: checkoutModel)
        case CheckoutReviewCells.shipping.rawValue:
            return getShippingCell(model: checkoutModel)
        case CheckoutReviewCells.products.rawValue:
            return getProductsCell(products: self.viewModel.summaryData?.products)
        case CheckoutReviewCells.summary.rawValue:
            return getSummaryCell(summary: self.viewModel.summaryData?.summary)
        default:
            return UITableViewCell()
        }
        
    }
}
