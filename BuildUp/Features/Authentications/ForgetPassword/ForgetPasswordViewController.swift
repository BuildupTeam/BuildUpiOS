//
//  ForgetPasswordViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/11/2023.
//

import UIKit

class ForgetPasswordViewController: BaseViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var contentLable: UILabel!
    @IBOutlet private weak var forgetPasswordButton: UIButton!

    @IBOutlet private weak var emailContainerView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var emailTitleLable: UILabel!
    @IBOutlet private weak var errorLable: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    private var viewModel: ForgetPasswordViewModel!
    var email: String?
    // MARK: - init methods
    
    init(viewModel: ForgetPasswordViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgetPasswordResponse()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
}

// MARK: - Private Functions
extension ForgetPasswordViewController {
    private func setupView() {
        self.setupToHideKeyboardOnTapOnView()
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        forgetPasswordButton.backgroundColor = .dimmedButtonGray
        //ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        forgetPasswordButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        forgetPasswordButton.setTitle(L10n.ForgetPassword.Button.sendReset, for: .normal)
        forgetPasswordButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        ThemeManager.setCornerRadious(element: forgetPasswordButton, radius: 8)
        
        titleLable.text = L10n.ForgetPassword.title
        titleLable.font = .appFont(ofSize: 24, weight: .semiBold)
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        contentLable.text = L10n.ForgetPassword.content
        contentLable.font = .appFont(ofSize: 13, weight: .regular)
        contentLable.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        emailTitleLable.text = L10n.Register.email
        emailTitleLable.font = .appFont(ofSize: 14, weight: .medium)
        emailTitleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        emailContainerView.layer.cornerRadius = 8
        emailContainerView.layer.masksToBounds = true
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        errorView.hideView()
        errorLable.text = L10n.Validation.requiredField
        errorLable.textColor = UIColor.statusRed
        errorLable.font = .appFont(ofSize: 12, weight: .regular)
        
        textField.delegate = self
        textField.showDoneButtonOnKeyboard()
        textField.returnKeyType = .done
        textField.backgroundColor = .clear
        textField.keyboardType = .emailAddress
        
        textField.setPlaceholder(
            placeholder: "\(L10n.Register.emailPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    private func updateForgetPasswordButtonAppearence() {
        if self.email != nil &&
            !(self.email?.isEmpty ?? false) &&
            isValidEmail(email ?? "") {
            forgetPasswordButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            forgetPasswordButton.isUserInteractionEnabled = true
        } else {
            forgetPasswordButton.backgroundColor = .dimmedButtonGray
            forgetPasswordButton.isUserInteractionEnabled = false
        }
    }
}

// MARK: - Response
extension ForgetPasswordViewController {
    private func forgetPasswordResponse() {
        viewModel.onForgetPassword = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            let resetPasswordVC = Coordinator.Controllers.createResetPasswordViewController()
            resetPasswordVC.email = self.email
            self.navigationController?.pushViewController(resetPasswordVC, animated: true)
        }
    }
}

// MARK: - IBActions
extension ForgetPasswordViewController {
    @IBAction func forgetPasswordAction(_ sender: Any) {
        updateForgetPasswordButtonAppearence()
        self.showLoading()
        self.viewModel.forgetPassword(email: self.email ?? "")
    }
}

// MARK: - UITextFieldDelegate
extension ForgetPasswordViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let email = textField.text, !email.isEmpty {
            self.email = email
            
            if isValidEmail(email) {
                errorView.hideView()
                emailContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
            } else {
                errorView.showView()
                errorLable.text = L10n.Validation.invalidEmailFormate
                emailContainerView.layer.borderColor = UIColor.statusRed.cgColor
            }
        } else {
            errorView.showView()
            errorLable.text = L10n.Validation.requiredField
            emailContainerView.layer.borderColor = UIColor.statusRed.cgColor
        }
        
        updateForgetPasswordButtonAppearence()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
