//
//  LoginViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/06/2023.
//

import UIKit
import PhoneNumberKit
import CountryPickerView

class LoginViewController: BaseViewController {

    @IBOutlet private weak var loginTitleLable: UILabel!
    @IBOutlet private weak var forgetPasswordLable: UILabel!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var countryFlagImageView: UIImageView!
    @IBOutlet private weak var seperatorView: UIView!
    @IBOutlet private weak var containerView: UIView!

    @IBOutlet private weak var phoneTitleLable: UILabel!
    @IBOutlet private weak var phoneErrorLable: UILabel!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var phoneContainerView: UIView!
    @IBOutlet private weak var phoneErrorView: UIView!
    
    @IBOutlet private weak var passwordTitleLable: UILabel!
    @IBOutlet private weak var passwordErrorLable: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordContainerView: UIView!
    @IBOutlet private weak var passwordErrorView: UIView!
    @IBOutlet private weak var showHidePasswordImageView: UIView!

    @IBOutlet private weak var privacyLabel1: UILabel!
    @IBOutlet private weak var privacyLabel2: UILabel!
    @IBOutlet private weak var termsButton: UIButton!
    @IBOutlet private weak var privacyButton: UIButton!
    
    var loginModel = LoginModel()
    private var viewModel: LoginViewModel!
    var countryPickerView = CountryPickerView()
    
    // MARK: - init methods
    
    init(viewModel: LoginViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginResponse()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }

}

// MARK: - Private Functions
extension LoginViewController {
    private func setupView() {
        setupToHideKeyboardOnTapOnView()
        setupCountryPickerView()
        setupMobileField()
        setupPasswordField()
        setupPrivacySection()
        updateLoginButtonAppearence()
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        loginTitleLable.text = L10n.Login.title
        loginTitleLable.font = .appFont(ofSize: 24, weight: .bold)
        loginTitleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        forgetPasswordLable.attributedText = NSAttributedString(string: L10n.Login.forgetPassword, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
//        forgetPasswordLable.text = L10n.Login.forgetPassword
        forgetPasswordLable.font = .appFont(ofSize: 12, weight: .regular)
        forgetPasswordLable.textColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "")
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 8
        loginButton.backgroundColor = .dimmedButtonGray
        //ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        loginButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        loginButton.setTitle(L10n.Login.title, for: .normal)
        loginButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        createAccountButton.titleLabel?.font = .appFont(ofSize: 14.5, weight: .semiBold)
        createAccountButton.setTitle(L10n.Login.createAccount, for: .normal)
        createAccountButton.setTitleColor(ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? ""), for: .normal)
        
        seperatorView.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
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
    
    private func setupCountryPickerView() {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        phoneTextField.textAlignment = .left
        
        countryPickerView.setCountryByCode("SA")
        self.countryFlagImageView.image = countryPickerView.getCountryByCode("SA")?.flag
//        self.countryCodeLabel.text = countryPickerView.getCountryByCode("EG")?.phoneCode
    }
    
    private func setupMobileField() {
        phoneTitleLable.text = L10n.Login.phone
        phoneTitleLable.font = .appFont(ofSize: 14, weight: .medium)
        phoneTitleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        phoneContainerView.layer.cornerRadius = 8
        phoneContainerView.layer.masksToBounds = true
        phoneContainerView.layer.borderWidth = 1
        phoneContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        phoneTextField.delegate = self
        phoneTextField.showDoneButtonOnKeyboard()
        phoneTextField.returnKeyType = .done
        phoneTextField.backgroundColor = .clear
//        phoneTextField.text = L10n.Login.phone
        phoneTextField.keyboardType = .asciiCapableNumberPad
        phoneTextField.setPlaceholder(
            placeholder: "\(L10n.Login.phonePlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
        phoneErrorLable.font = .appFont(ofSize: 12, weight: .regular)
        phoneErrorLable.textColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
        phoneErrorView.hideView()
    }
    
    private func setupPasswordField() {
        passwordTitleLable.text = L10n.Login.password
        passwordTitleLable.font = .appFont(ofSize: 14, weight: .medium)
        passwordTitleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        
        passwordContainerView.layer.cornerRadius = 8
        passwordContainerView.layer.masksToBounds = true
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        passwordTextField.delegate = self
        passwordTextField.showDoneButtonOnKeyboard()
        passwordTextField.returnKeyType = .done
        passwordTextField.backgroundColor = .clear
//        phoneTextField.text = L10n.Login.phone
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setPlaceholder(
            placeholder: "\(L10n.Login.passwordPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
        passwordErrorLable.font = .appFont(ofSize: 12, weight: .regular)
        passwordErrorLable.textColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
        passwordErrorView.hideView()
    }
    
    private func updateLoginButtonAppearence() {
        if self.loginModel.phone != nil &&
            self.loginModel.password != nil &&
            !(self.loginModel.phone?.isEmpty ?? false) &&
            !(self.loginModel.password?.isEmpty ?? false) &&
            isValidPassword(password: self.loginModel.password ?? "") &&
            isMobileNumberValid(phone: self.loginModel.phone ?? "") {
            loginButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            loginButton.isUserInteractionEnabled = true
        } else {
            loginButton.backgroundColor = .dimmedButtonGray
            loginButton.isUserInteractionEnabled = false
        }
    }
    
    func isMobileNumberValid(phone: String) -> Bool {
        let countryCode = countryPickerView.selectedCountry.phoneCode

        let phoneNumberKit = PhoneNumberKit()
        do {
            _ = try phoneNumberKit.parse(countryCode + phone)
            phoneErrorView.hideView()
            phoneContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
            return true
        } catch {
            phoneErrorView.showView()
            phoneContainerView.layer.borderColor = UIColor.statusRed.cgColor
            phoneErrorLable.text = L10n.Validation.invalidMobileNumber
            phoneErrorLable.textColor = UIColor.statusRed
            return false
        }
    }
    
    private func validateMobileNumber() {
        let isValid = isMobileNumberValid(phone: phoneTextField.text ?? "")
        self.loginModel.isValidMobileNumber = isValid
        if isValid {
            self.loginModel.phone = phoneTextField.text
        }
    }
    
    private func validatePassword() {
        let isValid = isValidPassword(password: passwordTextField.text ?? "")
        self.loginModel.isValidPasssword = isValid
        
        if isValid {
            passwordErrorView.hideView()
            passwordContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
            self.loginModel.password = passwordTextField.text
        } else {
            passwordErrorView.showView()
            passwordContainerView.layer.borderColor = UIColor.statusRed.cgColor
            passwordErrorLable.text = L10n.Validation.invalidPasswordFormate
            passwordErrorLable.textColor = UIColor.statusRed
        }
    }
    
    private func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        //"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}

// MARK: - Response
extension LoginViewController {
    private func loginResponse() {
        viewModel.onLogin = { [weak self] () in
            guard let `self` = self else { return }
            PersistanceManager.setLatestViewController(Constant.ControllerName.home)
            LauncherViewController.showTabBar()
        }
    }
}

// MARK: - Actions
extension LoginViewController {
    @IBAction func countryCodeAction(_ sender: Any) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func showHidePasswordAction(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let registerVC = Coordinator.Controllers.createRegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.showLoading()
        self.viewModel.loginUser(model: self.loginModel)
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        let forgetPasswordVC = Coordinator.Controllers.createForgetPasswordViewController()
        self.navigationController?.pushViewController(forgetPasswordVC, animated: true)
    }
}

// MARK: - Search TextField Delegate
extension LoginViewController: UITextFieldDelegate {
    
    @IBAction func textFieldDidChanged(textField: UITextField) {
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            self.loginModel.phone = textField.text
            validateMobileNumber()
        } else if textField == passwordTextField {
            self.loginModel.password = textField.text
            validatePassword()
        }
        
        updateLoginButtonAppearence()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Country PickerView Delegate
extension LoginViewController: CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.countryFlagImageView.image = country.flag
        self.loginModel.countryCode = country.phoneCode
        self.loginModel.countryFlag = country.flag
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
