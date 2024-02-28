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
import PopupDialog

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
    
    var profileID: String?
    var serverKey: String?
    var clientKey: String?
    
    /*
     var profileID = "134477"
     var serverKey = "S2J99KHW2M-JHJWBG99GD-GKG62BR2L9"
     var clientKey = "CBK22V-V7TR6H-6V2TPP-TVQGBV"
     */
    
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
    
    private func setupRejectedProducts(_ products: [ProductModel]) {
        let vc = RejectedProductsViewController()
        vc.delegate = self
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: false, panGestureDismissal: false)
        
        vc.products = products
        self.present(popup, animated: true)
    }
    
    private func setupTotalPrice() {
        checkoutContainerHeightConstraint.constant = 137
        checkoutContainerView.showView()
        if let summary = self.viewModel.summaryData?.summary {
            subtotalLabel.text = summary.formattedTotal?.formatted
        }
    }
    
    private func getPaymentCredentails() {
        
        if let payment = checkoutModel?.paymentMethod, payment.identifier == "cod" {
//            self.viewModel.completeOrder(transactionId: transactionDetails.transactionReference ?? "")
        } else {
            if let model = checkoutModel?.paymentMethod {
                if let response = decryptMsg(encryptedString: model.gateway?.config ?? "") {
                    self.profileID = response["profile_id"]
                    self.serverKey = response["server_key"]
                    self.clientKey = response["client_key"]
                    
                    self.payWithCard()
                }
            }
        }        
    }
    
    func decryptMsg(encryptedString: String) -> [String: String]? {
        guard let decodedData = Data(base64Encoded: encryptedString) else {
            print("Failed to decode Base64 string")
            return [:]
        }
        
        // Extract the IV, key, and encrypted data based on their positions
        let iv = decodedData.prefix(16)
        let key = decodedData.suffix(32)
        let encryptedData = decodedData.dropFirst(16).dropLast(32)
        
        do {
            let aes = try AES(key: Array(key), blockMode: CTR(iv: Array(iv)), padding: .noPadding)
            let decryptedBytes = try aes.decrypt(Array(encryptedData))
            let decryptedData = Data(decryptedBytes)
            
            if let decryptedString = String(data: decryptedData, encoding: .utf8) {
                print("Decrypted string: \(decryptedString)")
                
                let dict = decryptedString.toJSON() as? [String: String]
                print("dict = \(String(describing: dict))")
                return dict
                
            } else {
                print("Failed to convert decrypted data to string.")
            }
        } catch {
            print("Decryption error: \(error.localizedDescription)")
        }
        
        return [:]
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
                                        city: city,
                                        state: state,
                                        countryCode: countryCode,
                                        zip: "12345")
    }
    
    func getCardConfiguration() -> PaymentSDKConfiguration {
        guard let model = self.viewModel.checkoutData?.order else { return PaymentSDKConfiguration() }
        let countryCode = checkoutModel?.countryCodeText ?? "EG"
        let currency = CachingService.getThemeData()?.currency ?? ""
        
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "Logo")
        return PaymentSDKConfiguration(profileID: profileID ?? "",
                                       serverKey: serverKey ?? "",
                                       clientKey: clientKey ?? "",
                                       currency: currency,
                                       amount: model.formattedTotal?.amount ?? 0.0,
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

extension CheckoutReviewViewController: RejectedProductsDelegate {
    func backToCartButtonClicked() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Responses
extension CheckoutReviewViewController {
    private func setupResponses() {
        checkoutResponse()
        summaryResponse()
        summaryErrorResponse()
        paymentCancelledResponse()
        completeOrderResponse()
    }
    
    private func summaryResponse() {
        self.viewModel.onSummary = { [weak self](summaryData) in
            guard let `self` = self else { return }
            self.hideLoading()
            self.setupTotalPrice()
            self.tableView.reloadData()
            
            if let rejectedPoducts = summaryData?.rejectedPoducts, !rejectedPoducts.isEmpty {
                self.setupRejectedProducts(rejectedPoducts)
            }
        }
    }
    
    private func summaryErrorResponse() {
        self.viewModel.onErrorMessage = { [weak self](message) in
            guard let `self` = self else { return }
            self.hideLoading()
            self.showError(message: message)
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
                    LauncherViewController.showTabBar(fromViewController: nil)
                } else {
                    self.getPaymentCredentails()
//                    self.payWithCard()
                }
            }
        }
    }
    
    private func paymentCancelledResponse() {
        self.viewModel.onPaymentCancelled = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            self.showError(message: "payment cancelled")
//            RealTimeDatabaseService.clearCart()
//            LauncherViewController.showTabBar()
        }
    }
    
    private func completeOrderResponse() {
        self.viewModel.onCompleteOrder = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            RealTimeDatabaseService.clearCart()
            LauncherViewController.showTabBar(fromViewController: nil)
        }
    }
}
