//
//  CheckoutReviewViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit
import PaymentSDK
import PassKit
import CryptoSwift
import Foundation
import ObjectMapper
import CryptoKit

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
    
    let profileID = "134477"
    let serverKey = "S2J99KHW2M-JHJWBG99GD-GKG62BR2L9"
    let clientKey = "CBK22V-V7TR6H-6V2TPP-TVQGBV"
    
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
        setupResponses()
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
        
        headerView.backgroundColor = ThemeManager.colorPalette?.mainBg2?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg2 ?? "")
        
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
        
        self.decryptMsg(config: checkoutModel?.paymentMethod?.gateway?.config ?? "")
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
            let subtotal = (summary.subtotal ?? 0) + (summary.shippingDetails?.amount ?? 0)
            subtotalLabel.text = L10n.Cart.currency + String(subtotal)
        }
    }
    
    private func decryptMsg(config: String) -> PaymentConfig? {
        do {
            guard let decodedData = Data(base64Encoded: config) else { return nil }
            let iv = Array(decodedData[0..<16]) // Extract IV (first 16 bytes)
            let key = Array(decodedData[(decodedData.count - 32)..<decodedData.count])
            let encryptedData = Array(decodedData[16..<(decodedData.count - 32)])
            let secret = SymmetricKey(data: key)
            /* Decrypt the message, given derived encContentValues and initialization vector. */
            let cipher = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
//            let cipher = try AES(key: secret, iv: iv, padding: .noPadding)
            let decryptedData = try cipher.decrypt(encryptedData)
            if let jsonResponse = String(data: Data(decryptedData), encoding: .utf8) {
                let paymentConfigResponse = Mapper<PaymentConfig>().map(JSONObject: jsonResponse)
                return paymentConfigResponse 
                //try JSONDecoder().decode(PaymentConfig.self, from: json.data(using: .utf8)!)
            }
        } catch {
            return nil
        }
        return nil
    }
}

// MARK: Actions
extension CheckoutReviewViewController {
    @IBAction func checkoutAction(_ sender: UIButton) {
        if let model = checkoutModel {
            self.showLoading()
            self.viewModel.checkout(model: model)
        }
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
// MARK: - Payment
extension CheckoutReviewViewController: PaymentManagerDelegate {
    
    func payWithCard() {
        PaymentManager.startCardPayment(on: self, configuration: getCardConfiguration(),
                                 delegate: self)
    }
    
    func getBillingAddress() -> PaymentSDKBillingDetails {
        guard let model = checkoutModel else { return PaymentSDKBillingDetails() }
        
        let name = model.name
        let email = model.email
        let phone = model.phone
        let city = model.address?.city?.name
        let state = model.address?.area?.name
        let countryCode = model.countryCodeText
        let addressLine = model.address?.addressDescription
        
        return PaymentSDKBillingDetails(name: name,
                                        email: email,
                                        phone: phone,
                                        addressLine: addressLine,
                                        city: "Cairo",
                                        state: "Nasr City",
                                        countryCode: countryCode,
                                        zip: "12345")
    }
    
    func getCardConfiguration() -> PaymentSDKConfiguration {
        guard let model = self.viewModel.checkoutData?.order else { return PaymentSDKConfiguration() }
        let countryCode = checkoutModel?.countryCodeText ?? "EG"

        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "Logo")
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "EGP",
                                       amount: model.total ?? 0.0,
                                       merchantCountryCode: countryCode)
        .cartDescription("Flowers")
        .cartID(model.uuid ?? "")
        .screenTitle("Pay with Card")
        .theme(theme)
        .billingDetails(getBillingAddress())
    }
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDK.PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print("transactionDetails = \(transactionDetails)")
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
            
            if transactionDetails.isSuccess() {
                print("Successful transaction")
                self.viewModel.completeOrder(transactionId: transactionDetails.transactionReference ?? "")
            } else {
                self.viewModel.paymentCancelled()
            }
        } else if let error = error {
            showError(message: error.localizedDescription)
        }
    }
}

// MARK: - Responses
extension CheckoutReviewViewController {
    private func setupResponses() {
        checkoutResponse()
        summaryResponse()
        paymentCancelledResponse()
        completeOrderResponse()
    }
    
    private func summaryResponse() {
        self.viewModel.onSummary = { [weak self]() in
            guard let `self` = self else { return }
            self.hideLoading()
            self.setupTotalPrice()
            self.tableView.reloadData()
        }
    }
    
    private func checkoutResponse() {
        self.viewModel.onCheckout = { [weak self] (response) in
            guard let `self` = self else { return }
            self.hideLoading()
            if let data = self.viewModel.checkoutData {
                if data.confirmed ?? false {
                    RealTimeDatabaseService.clearCart()
                    LauncherViewController.showTabBar()
                } else {
                    self.payWithCard()
                }
            }
        }
    }
    
    private func paymentCancelledResponse() {
        self.viewModel.onPaymentCancelled = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
//            RealTimeDatabaseService.clearCart()
//            LauncherViewController.showTabBar()
        }
    }
    
    private func completeOrderResponse() {
        self.viewModel.onCompleteOrder = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            RealTimeDatabaseService.clearCart()
            LauncherViewController.showTabBar()
        }
    }
}
