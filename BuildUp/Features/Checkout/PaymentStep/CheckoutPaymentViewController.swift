//
//  CheckoutPaymentViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit
import CryptoSwift
import Foundation
import ObjectMapper
import CryptoKit

class CheckoutPaymentViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var headerView: CheckoutStatusView!
    @IBOutlet private weak var choosePaymentLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!
    
    override  var prefersBottomBarHidden: Bool? { return true }

    var checkoutModel: CheckoutModel?

    var viewModel: CheckoutPaymentViewModel!
    
    init(viewModel: CheckoutPaymentViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getPaymentMethods()
        handleResponse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = L10n.Checkout.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
    
    private func setupView() {
        registerTableViewCells()
        
        headerView.setupView()
        headerView.setupPaymentView()
        headerView.backgroundColor = ThemeManager.colorPalette?.mainBg2?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg2 ?? "")

        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        choosePaymentLabel.text = L10n.Checkout.choosePayment
        choosePaymentLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        choosePaymentLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        continueButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        continueButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        continueButton.setTitle(L10n.Checkout.continue, for: .normal)
        continueButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        ThemeManager.setCornerRadious(element: continueButton, radius: 8)
    }
    
    private func getPaymentMethods() {
        if let countryCode = CachingService.getThemeData()?.appCountryId?.iso {
            self.viewModel.getPaymentMethods(countryCode: countryCode)
        }
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: CheckoutPaymentMethodTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutPaymentMethodTableViewCell.identifier)
    }
}

// MARK: - TableView Delegate && DataSource
extension CheckoutPaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.paymentMethods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutPaymentMethodTableViewCell.identifier,
            for: indexPath) as? CheckoutPaymentMethodTableViewCell
        else { return UITableViewCell() }
        
        cell.paymentMethodModel = self.viewModel.paymentMethods?[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let paymentMethods = self.viewModel.paymentMethods {
            for address in paymentMethods {
                address.isSelected = false
            }
            if let model = self.viewModel.paymentMethods?[indexPath.row] {
                model.isSelected = true
                self.viewModel.paymentMethods?[indexPath.row] = model
                self.checkoutModel?.paymentMethod = model
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: Actions
extension CheckoutPaymentViewController {
    @IBAction func continueAction(_ sender: UIButton) {
//        self.showLoading()
        let checkoutReviewVC = Coordinator.Controllers.createCheckoutReviewViewController()
        checkoutReviewVC.checkoutModel = self.checkoutModel
        self.navigationController?.pushViewController(checkoutReviewVC, animated: true)
    }
}

// MARK: Responses
extension CheckoutPaymentViewController {
    func handleResponse() {
        self.viewModel.onPaymentMethods = { [weak self]() in
            guard let `self` = self else { return }
            self.hideLoading()
            self.tableView.reloadData()
        }
    }
}
