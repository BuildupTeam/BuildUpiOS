//
//  CheckoutShippingViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit
import PhoneNumberKit
import CountryPickerView

enum CheckoutShippingCells: Int {
    case name = 0
    case phone
}

class CheckoutShippingViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var headerView: CheckoutStatusView!
    @IBOutlet private weak var continueButton: UIButton!

    var viewModel: CheckoutShippingViewModel!
    var countryPickerView = CountryPickerView()
    
    var checkoutModel = CheckoutModel()
    // MARK: - init methods
    var isReloadingTableView = false
    var addressModel: AddressModel?
    
    override  var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: CheckoutShippingViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCountryPickerView()
        registerTableViewCells()
        setupView()
        addressesResponse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAddresses()
        self.title = L10n.Checkout.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: RegisterPhoneTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterPhoneTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: RegisterNameTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RegisterNameTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutAddressTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutAddressTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutHeaderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutHeaderTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CheckoutAddAddressTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CheckoutAddAddressTableViewCell.identifier)
    }

}

// MARK: - Private Func
extension CheckoutShippingViewController {
    private func setupView() {
        fillUserData()
        registerKeyboardObservers()
        updateContinueButtonAppearence()
        
        headerView.setupView()
        headerView.setupShippingView()
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 8
//        continueButton.backgroundColor = .dimmedButtonGray
        continueButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        continueButton.setTitle(L10n.Checkout.continue, for: .normal)
        continueButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
    }
    
    private func fillUserData() {
        let userName = CachingService.getUser()?.customer?.fullName
        let phone = CachingService.getUser()?.customer?.phone
        let phoneCode = "+\(CachingService.getUser()?.customer?.countryCode ?? "")"
        let countryFlag = countryPickerView.getCountryByPhoneCode(phoneCode)?.flag
        
        checkoutModel.name = userName
        checkoutModel.phone = phone
        checkoutModel.countryCode = phoneCode
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
    
    private func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        //"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    private func updateContinueButtonAppearence() {
        if self.checkoutModel.name != nil &&
            !(self.checkoutModel.name?.isEmpty ?? false) &&
            self.checkoutModel.phone != nil &&
            !(self.checkoutModel.phone?.isEmpty ?? false) &&
            self.checkoutModel.address?.id != nil {
            continueButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            continueButton.isUserInteractionEnabled = true
        } else {
            continueButton.backgroundColor = .dimmedButtonGray
            continueButton.isUserInteractionEnabled = false
        }
    }
    
    private func getAddresses() {
        self.viewModel.getAddresses()
    }
    
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.tableView.reloadData()
    }
    
    private func openAddAddressScreen() {
        let addAddressVC = Coordinator.Controllers.createAddNewAddressViewController()
        self.navigationController?.pushViewController(addAddressVC, animated: true)
    }
    
    private func openAddressesScreen() {
        let AddressesVC = Coordinator.Controllers.createAddressesViewController()
        self.navigationController?.pushViewController(AddressesVC, animated: true)
    }
}

// MARK: Actions
extension CheckoutShippingViewController {
    @IBAction func continueAction(_ sender: UIButton) {
//        self.showLoading()
        let checkoutPaymentVC = Coordinator.Controllers.createCheckoutPaymentViewController()
        self.navigationController?.pushViewController(checkoutPaymentVC, animated: true)
    }
}

// MARK: Get Cells
extension CheckoutShippingViewController {
    private func getSectionHeaderCell(section: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutHeaderTableViewCell.identifier) as? CheckoutHeaderTableViewCell
            else { return UITableViewCell() }
        
        cell.section = section
        cell.selectionStyle = .none
        return cell
    }
    
    private func getNameCell(model: CheckoutModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterNameTableViewCell.identifier) as? RegisterNameTableViewCell
        else { return UITableViewCell() }
        
        cell.checkoutModel = model
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getPhoneCell(model: CheckoutModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RegisterPhoneTableViewCell.identifier) as? RegisterPhoneTableViewCell
        else { return UITableViewCell() }
        
        cell.checkoutModel = model
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getAddressCell(model: AddressModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutAddressTableViewCell.identifier) as? CheckoutAddressTableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getAddNewAddressCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutAddAddressTableViewCell.identifier) as? CheckoutAddAddressTableViewCell
        else { return UITableViewCell() }
        
        
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Delegate && DataSource
extension CheckoutShippingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case CheckoutShippingCells.name.rawValue:
                return getNameCell(model: checkoutModel)
            case CheckoutShippingCells.phone.rawValue:
                return getPhoneCell(model: checkoutModel)
            default:
                return UITableViewCell()
            }
        case 1:
            if let addresses = self.viewModel.addresses, 
                !addresses.isEmpty,
                let addressModel = addresses.first {
                return getAddressCell(model: addressModel)
            } else {
                return getAddNewAddressCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getSectionHeaderCell(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            if let addresses = self.viewModel.addresses,
                !addresses.isEmpty {
                return
            } else {
                openAddAddressScreen()
            }
        default:
            return
        }
    }
    
    /*
     switch indexPath.row {
     case 0:
         return getAddressCell()
     case 1:
         return getAddNewAddressCell()
     default:
         return UITableViewCell()
     }
     */
}

// MARK: - Country PickerView Delegate
extension CheckoutShippingViewController: CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.checkoutModel.countryCode = country.phoneCode
        self.checkoutModel.countryFlag = country.flag
        
        self.tableView.reloadData()
//        updateRegisterButtonAppearence()
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
extension CheckoutShippingViewController: RegisterCellDelegate {
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

extension CheckoutShippingViewController: CheckoutAddressCellDelegate {
    func changeButtonClicked() {
        openAddressesScreen()
    }
}

// MARK: - Responses
extension CheckoutShippingViewController {
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
            
            self.tableView.reloadData()
            updateContinueButtonAppearence()
        }
    }
}
