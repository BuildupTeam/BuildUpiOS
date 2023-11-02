//
//  ResetPasswordViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/11/2023.
//

import UIKit

class ResetPasswordViewController: BaseViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var contentLable: UILabel!
    @IBOutlet private weak var resetPasswordButton: UIButton!

    @IBOutlet private weak var passwordTitleLable: UILabel!
    @IBOutlet private weak var passwordErrorLable: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordContainerView: UIView!
    @IBOutlet private weak var passwordErrorView: UIView!
    @IBOutlet private weak var showHidePasswordImageView: UIView!
    
    @IBOutlet private weak var confirmedPasswordTitleLable: UILabel!
    @IBOutlet private weak var confirmedPasswordErrorLable: UILabel!
    @IBOutlet private weak var confirmedPasswordTextField: UITextField!
    @IBOutlet private weak var confirmedPasswordContainerView: UIView!
    @IBOutlet private weak var confirmedPasswordErrorView: UIView!
    @IBOutlet private weak var showHideConfirmedPasswordImageView: UIView!

    private var viewModel: ResetPasswordViewModel!
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    // MARK: - init methods
    
    init(viewModel: ResetPasswordViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordResponse()
        setupView()
    }
    
    private func setupView() {
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        titleLable.text = L10n.ResetPassword.title
        titleLable.font = .appFont(ofSize: 24, weight: .semiBold)
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        contentLable.text = L10n.ResetPassword.content
        contentLable.font = .appFont(ofSize: 13, weight: .regular)
        contentLable.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        resetPasswordButton.layer.masksToBounds = true
        resetPasswordButton.layer.cornerRadius = 8
        resetPasswordButton.backgroundColor = .dimmedButtonGray
        //ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        resetPasswordButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        resetPasswordButton.setTitle(L10n.ResetPassword.Button.reset, for: .normal)
        resetPasswordButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
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
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setPlaceholder(
            placeholder: "\(L10n.Login.passwordPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
        
        passwordErrorLable.font = .appFont(ofSize: 12, weight: .regular)
        passwordErrorLable.textColor = UIColor.statusRed
        passwordErrorView.hideView()
        
        confirmedPasswordTitleLable.text = L10n.Login.password
        confirmedPasswordTitleLable.font = .appFont(ofSize: 14, weight: .medium)
        confirmedPasswordTitleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        confirmedPasswordContainerView.layer.cornerRadius = 8
        confirmedPasswordContainerView.layer.masksToBounds = true
        confirmedPasswordContainerView.layer.borderWidth = 1
        confirmedPasswordContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        confirmedPasswordTextField.delegate = self
        confirmedPasswordTextField.showDoneButtonOnKeyboard()
        confirmedPasswordTextField.returnKeyType = .done
        confirmedPasswordTextField.backgroundColor = .clear
        confirmedPasswordTextField.keyboardType = .default
        confirmedPasswordTextField.isSecureTextEntry = true
        confirmedPasswordTextField.setPlaceholder(
            placeholder: "\(L10n.Login.passwordPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
        
        confirmedPasswordErrorLable.font = .appFont(ofSize: 12, weight: .regular)
        confirmedPasswordErrorLable.textColor = UIColor.statusRed
        confirmedPasswordErrorView.hideView()
    }
    
    private func updateResetPasswordButtonAppearence() {
        if self.password != nil &&
            !(self.password?.isEmpty ?? false) &&
            self.confirmPassword != nil &&
            !(self.confirmPassword?.isEmpty ?? false) &&
            isValidPassword(password: password ?? "") &&
            isValidPassword(password: confirmPassword ?? "") {
            resetPasswordButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            resetPasswordButton.isUserInteractionEnabled = true
        } else {
            resetPasswordButton.backgroundColor = .dimmedButtonGray
            resetPasswordButton.isUserInteractionEnabled = false
        }
    }
    
    private func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        //"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

}

// MARK: - Response
extension ResetPasswordViewController {
    private func resetPasswordResponse() {
        viewModel.onResetPassword = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            PersistanceManager.setLatestViewController(Constant.ControllerName.home)
            LauncherViewController.showTabBar()
        }
    }
}

// MARK: - IBActions
extension ResetPasswordViewController {
    @IBAction func resetPasswordAction(_ sender: Any) {
        updateResetPasswordButtonAppearence()
        self.showLoading()
        self.viewModel.resetPassword(email: self.email ?? "", password: self.password ?? "")
    }
    
    @IBAction func showHidePasswordAction(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func showHideConfirmedPasswordAction(_ sender: Any) {
        confirmedPasswordTextField.isSecureTextEntry = !confirmedPasswordTextField.isSecureTextEntry
    }
}

// MARK: - Search TextField Delegate
extension ResetPasswordViewController: UITextFieldDelegate {
    
    @IBAction func textFieldDidChanged(textField: UITextField) {
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField {
             password = textField.text
            
            if let password = textField.text, !password.isEmpty {
                if isValidPassword(password: password) {
                    passwordErrorView.hideView()
                    passwordContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
                    
                    self.password = password
                } else {
                    passwordErrorView.showView()
                    passwordErrorLable.text = L10n.Validation.invalidPasswordFormate
                    passwordContainerView.layer.borderColor = UIColor.statusRed.cgColor
                }
            } else {
                passwordErrorView.showView()
                passwordErrorLable.text = L10n.Validation.requiredField
                passwordContainerView.layer.borderColor = UIColor.statusRed.cgColor
            }
        } else if textField == confirmedPasswordTextField {
            confirmPassword = textField.text
            
            if let confirmedPassword = textField.text, !confirmedPassword.isEmpty {
                if confirmedPassword != password {
                    confirmedPasswordErrorView.showView()
                    confirmedPasswordErrorLable.text = L10n.Validation.passwordNotMatch
                    confirmedPasswordContainerView.layer.borderColor = UIColor.statusRed.cgColor
                    return
                }
                
                if isValidPassword(password: confirmedPassword) {
                    confirmedPasswordErrorView.hideView()
                    confirmedPasswordContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
                    
                    self.confirmPassword = password
                } else {
                    confirmedPasswordErrorView.showView()
                    confirmedPasswordErrorLable.text = L10n.Validation.invalidPasswordFormate
                    confirmedPasswordContainerView.layer.borderColor = UIColor.statusRed.cgColor
                }
            } else {
                confirmedPasswordErrorView.showView()
                confirmedPasswordErrorLable.text = L10n.Validation.requiredField
                confirmedPasswordContainerView.layer.borderColor = UIColor.statusRed.cgColor
            }
        }
        
        updateResetPasswordButtonAppearence()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
