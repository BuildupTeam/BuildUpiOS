//
//  RegisterViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import UIKit
import PhoneNumberKit
import CountryPickerView

class RegisterViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var privacyLabel1: UILabel!
    @IBOutlet private weak var privacyLabel2: UILabel!
    @IBOutlet private weak var termsButton: UIButton!
    @IBOutlet private weak var privacyButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    var viewModel: RegisterViewModel!
    var countryPickerView = CountryPickerView()
    
    var registerModel = RegisterModel()
    // MARK: - init methods
    
    init(viewModel: RegisterViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        setupCountryPickerView()
        self.registerTableViewCells()
        registerResponse()
        setupView()
    }
    
    private func setupView() {
        setupPrivacySection()
        registerKeyboardObservers()
        updateRegisterButtonAppearence()
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        registerButton.backgroundColor = .dimmedButtonGray
        //ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        registerButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        registerButton.setTitle(L10n.Register.Button.createAccount, for: .normal)
        registerButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        ThemeManager.setCornerRadious(element: registerButton, radius: 8)
        
        titleLabel.text = L10n.Register.title
        titleLabel.font = .appFont(ofSize: 24, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
    }
    
    private func setupCountryPickerView() {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        countryPickerView.setCountryByCode("SA")
        
        self.registerModel.countryFlag = countryPickerView.getCountryByCode("SA")?.flag
        self.registerModel.countryCode = countryPickerView.selectedCountry.phoneCode
    }
    
    private func setupPrivacySection() {
        privacyLabel1.font = .appFont(ofSize: 12, weight: .regular)
        privacyLabel2.font = .appFont(ofSize: 12, weight: .regular)

        privacyLabel1.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        privacyLabel2.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        privacyLabel1.text = L10n.Login.privacyTitle
        privacyLabel2.text = L10n.Login.privacyAnd
        privacyLabel1.textAlignment = .center
        privacyLabel2.textAlignment = .center

        let privacyAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.appFont(ofSize: 12, weight: .regular),
            .foregroundColor: ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "") ?? .gray,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        
        let privacyAttributeString = NSMutableAttributedString(
            string: L10n.Login.privacyLabel,
            attributes: privacyAttributes
        )
        
        let termsAttributeString = NSMutableAttributedString(
            string: L10n.Login.termsLabel,
            attributes: privacyAttributes
        )
        
        privacyButton.setAttributedTitle(privacyAttributeString, for: .normal)
        termsButton.setAttributedTitle(termsAttributeString, for: .normal)
    }
    
    private func updateRegisterButtonAppearence() {
        if self.registerModel.name != nil &&
            !(self.registerModel.name?.isEmpty ?? false) &&
            self.registerModel.password != nil &&
            isValidPassword(password: self.registerModel.password ?? "") &&
            !(self.registerModel.password?.isEmpty ?? false) &&
            self.registerModel.confirmedPassword != nil &&
            isValidPassword(password: self.registerModel.confirmedPassword ?? "") &&
            !(self.registerModel.confirmedPassword?.isEmpty ?? false) &&
            self.registerModel.phone != nil &&
            !(self.registerModel.phone?.isEmpty ?? false) &&
            self.registerModel.email != nil &&
            !(self.registerModel.email?.isEmpty ?? false) &&
            self.registerModel.confirmedPassword == self.registerModel.password {
            registerButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            registerButton.isUserInteractionEnabled = true
        } else {
            registerButton.backgroundColor = .dimmedButtonGray
            registerButton.isUserInteractionEnabled = false
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
    
    private func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^[A-Za-z0-9 !\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~].{7,}$"
        //"((?=.\\d)(?=.[A-Z])(?=.*[a-z]).{8,})"
        //"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        self.showLoading()
        viewModel.registerUser(model: self.registerModel)
    }
    
    @IBAction func termsOfUseAction(_ sender: Any) {
        var configuration = Configuration()
        let termsOfUseURL = configuration.environment.termsOfUseURL
        
        openWebView(url: termsOfUseURL, pageTitle: L10n.Login.termsLabel)
    }
    
    @IBAction func privacyPolicyAction(_ sender: Any) {
        var configuration = Configuration()
        let privacyPolicyUrl = configuration.environment.privacyPolicyURL
        
        openWebView(url: privacyPolicyUrl, pageTitle: L10n.Login.privacyLabel)
    }
}

// MARK: - Response
extension RegisterViewController {
    private func registerResponse() {
        viewModel.onRegister = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            PersistanceManager.setLatestViewController(Constant.ControllerName.home)
            LauncherViewController.showTabBar(fromViewController: nil)
        }
    }
}

// MARK: - Country PickerView Delegate
extension RegisterViewController: CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.registerModel.countryCode = country.phoneCode
        self.registerModel.countryFlag = country.flag
        
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
extension RegisterViewController: RegisterCellDelegate {
    func countryCodeButtonClicked() {
        countryPickerView.showCountriesList(from: self)
    }
    
    func nameChanged(name: String) {
        self.registerModel.name = name
        updateRegisterButtonAppearence()
    }
    
    func emailChanged(email: String) {
        self.registerModel.email = email
        updateRegisterButtonAppearence()
    }
    
    func phoneChanged(phone: String) {
        self.registerModel.phone = phone
        updateRegisterButtonAppearence()
    }
    
    func countryCodeChanged(countryCode: String) {
        self.registerModel.countryCode = countryCode
        updateRegisterButtonAppearence()
    }
    
    func passwordChanged(password: String) {
        self.registerModel.password = password
        updateRegisterButtonAppearence()
    }
    
    func confirmedPasswordChanged(confirmedPassword: String) {
        self.registerModel.confirmedPassword = confirmedPassword
        updateRegisterButtonAppearence()
    }
}
