//
//  CheckoutViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 03/04/2024.
//

import UIKit
import PhoneNumberKit
import CountryPickerView
import PopupDialog

class CheckoutViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var continueButton: UIButton!
    
    var checkoutModel = CheckoutModel()
    var countryPickerView = CountryPickerView()
    var addressModel: AddressModel?

    var viewModel: CheckoutViewModel!
    var isReloadingTableView = false

    var profileID: String?
    var serverKey: String?
    var clientKey: String?
    var region: String?
    
    override var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: CheckoutViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        setupResponses()
        setupCountryPickerView()
        registerTableViewCells()
        setupView()
        getAddresses()
    }
}

extension CheckoutViewController {
    private func setupView() {
        fillUserData()
        registerKeyboardObservers()
        updateContinueButtonAppearence()
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        continueButton.backgroundColor = .dimmedButtonGray
        continueButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        continueButton.setTitle(L10n.Checkout.continue, for: .normal)
        continueButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        ThemeManager.setCornerRadious(element: continueButton, radius: 8)

    }
    
    private func fillUserData() {
        let userName = CachingService.getUser()?.customer?.fullName
        let email = CachingService.getUser()?.customer?.email
        let phone = CachingService.getUser()?.customer?.phone
        let phoneCode = "+\(CachingService.getUser()?.customer?.countryCode ?? "")"
        let countryFlag = countryPickerView.getCountryByPhoneCode(phoneCode)?.flag
        let countryCodeText = countryPickerView.getCountryByPhoneCode(phoneCode)?.code
        
        checkoutModel.name = userName
        checkoutModel.email = email
        checkoutModel.phone = phone
        checkoutModel.countryCode = phoneCode
        checkoutModel.countryCodeText = countryCodeText
        checkoutModel.countryFlag = countryFlag
        
        self.tableView.reloadData()
    }
    
    private func setupCountryPickerView() {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        countryPickerView.setCountryByCode("SA")
        
        self.checkoutModel.countryFlag = countryPickerView.getCountryByCode("SA")?.flag
        self.checkoutModel.countryCode = countryPickerView.selectedCountry.phoneCode
    }
    
    private func getAddresses() {
        self.viewModel.getAddresses()
    }
    
    private func getSummary() {
        if let model = checkoutModel.address {
            self.showLoading()
            self.viewModel.getSummary(model.id ?? 0)
        }
    }
    
    private func getPaymentMethods() {
        if let countryCode = CachingService.getThemeData()?.appCountryId?.iso {
            self.viewModel.getPaymentMethods(countryCode: countryCode)
        }
    }
    
    private func setupRejectedProducts(_ products: [ProductModel]) {
        let vc = RejectedProductsViewController()
        vc.delegate = self
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: false, panGestureDismissal: false)
        
        vc.products = products
        self.present(popup, animated: true)
    }
    
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.tableView.reloadData()
    }
    
    private func openAddAddressScreen() {
        let addAddressVC = Coordinator.Controllers.createAddNewAddressViewController()
        addAddressVC.delegate = self
        self.navigationController?.pushViewController(addAddressVC, animated: true)
    }
    
    private func openAddressesScreen() {
        let AddressesVC = Coordinator.Controllers.createAddressesViewController()
        AddressesVC.delegate = self
        AddressesVC.isCommingFromShipping = true
        self.navigationController?.pushViewController(AddressesVC, animated: true)
    }
    
    private func updateContinueButtonAppearence() {
        if self.checkoutModel.name != nil &&
            !(self.checkoutModel.name?.isEmpty ?? false) &&
            self.checkoutModel.phone != nil &&
            !(self.checkoutModel.phone?.isEmpty ?? false) &&
            self.checkoutModel.address?.id != nil &&
            self.checkoutModel.paymentMethod != nil {
            continueButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            continueButton.isUserInteractionEnabled = true
        } else {
            continueButton.backgroundColor = .dimmedButtonGray
            continueButton.isUserInteractionEnabled = false
        }
    }
    
    private func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 40, right: 0)
        }
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
}

// MARK: - Actions
extension CheckoutViewController {
    @IBAction func continueAction(_ sender: UIButton) {
        self.showLoading()
        self.viewModel.checkout(model: self.checkoutModel)
    }
}

// MARK: - Responses
extension CheckoutViewController {
    private func setupResponses() {
        checkoutResponse()
        summaryResponse()
        addressesResponse()
        paymenthMethodsResponse()
        summaryErrorResponse()
        paymentCancelledResponse()
        completeOrderResponse()
    }
    
    private func summaryResponse() {
        self.viewModel.onSummary = { [weak self](summaryData) in
            guard let `self` = self else { return }
            self.hideLoading()
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
                }
            }
        }
    }
    
    private func addressesResponse() {
        self.viewModel.onAddresses = { [weak self]() in
            guard let `self` = self else { return }
            if let addresses = self.viewModel.addresses, !addresses.isEmpty {
                self.addressModel = addresses.first(where: { $0.isDefault ?? false })
                if let model = self.addressModel {
                    self.checkoutModel.address = model
                } else {
                    self.checkoutModel.address = addresses.first
                }
            }
            self.getPaymentMethods()
            self.tableView.reloadData()
            self.updateContinueButtonAppearence()
        }
    }
    
    func paymenthMethodsResponse() {
        self.viewModel.onPaymentMethods = { [weak self]() in
            guard let `self` = self else { return }
            self.hideLoading()
            self.getSummary()
            self.tableView.reloadData()
        }
    }
    
    private func paymentCancelledResponse() {
        self.viewModel.onPaymentCancelled = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            self.showError(message: "payment cancelled")
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

// MARK: - Country PickerView Delegate
extension CheckoutViewController: CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.checkoutModel.countryCode = country.phoneCode
        self.checkoutModel.countryFlag = country.flag
        
        self.tableView.reloadData()
    }
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        if let egypt = countryPickerView.countries.first(where: { ($0.code == "EG") }),
           let usa = countryPickerView.countries.first(where: { ($0.code == "SA") }) {
                return [egypt, usa]
            }
        return []
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return ""
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func localeForCountryNameInList(in countryPickerView: CountryPickerView) -> Locale {
        return Locale(identifier: LocalizationManager.currentLanguage().iosLanguageCode)
    }
}

// MARK: - Cell Delegates
extension CheckoutViewController: RegisterCellDelegate {
    func emailChanged(email: String) {
    }
    func countryCodeChanged(countryCode: String) {
    }
    func passwordChanged(password: String) {
    }
    func confirmedPasswordChanged(confirmedPassword: String) {
    }
    func countryCodeButtonClicked() {
        countryPickerView.showCountriesList(from: self)
    }
    
    func nameChanged(name: String) {
        self.checkoutModel.name = name
        updateContinueButtonAppearence()
    }
    
    func phoneChanged(phone: String) {
        self.checkoutModel.phone = phone
        updateContinueButtonAppearence()
    }
}

extension CheckoutViewController: AddressesDelegate {
    func addressTaped(addressModel: AddressModel) {
        self.checkoutModel.address = addressModel
        updateContinueButtonAppearence()
        self.tableView.reloadData()
    }
}

extension CheckoutViewController: CheckoutAddressCellDelegate {
    func changeButtonClicked() {
        openAddressesScreen()
    }
}

extension CheckoutViewController: AddNewAddressDelegate {
    func newAddressAdded() {
        self.viewModel.getAddresses()
    }
}

extension CheckoutViewController: CheckoutPaymentMethodsDelegate {
    func paymentMetyhodSelected(paymentMethod: PaymentMethodModel) {
        self.checkoutModel.paymentMethod = paymentMethod
        updateContinueButtonAppearence()
        self.tableView.reloadData()
    }
}

extension CheckoutViewController: RejectedProductsDelegate {
    func backToCartButtonClicked() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
