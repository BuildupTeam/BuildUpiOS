//
//  RegisterPasswordTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import UIKit

class RegisterPasswordTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var passwordContainerView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var showHidePasswordImageView: UIView!

    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var errorLable: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    weak var delegate: RegisterCellDelegate?

    var registerModel: RegisterModel? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        titleLable.font = .appFont(ofSize: 14, weight: .medium)
        
        passwordContainerView.layer.cornerRadius = 8
        passwordContainerView.layer.masksToBounds = true
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        errorView.hideView()
        errorLable.text = L10n.Validation.requiredField
        errorLable.textColor = UIColor.statusRed
        errorLable.font = .appFont(ofSize: 12, weight: .regular)
        
        textField.delegate = self
        textField.showDoneButtonOnKeyboard()
        textField.returnKeyType = .done
        textField.backgroundColor = .clear
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
    }
    
    func setupPassword() {
        textField.tag = 100
        titleLable.text = L10n.Register.password
        textField.setPlaceholder(
            placeholder: "\(L10n.Register.passwordPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    func setupConfirmPassword() {
        textField.tag = 101
        titleLable.text = L10n.Register.confirmPassword
        textField.setPlaceholder(
            placeholder: "\(L10n.Register.confirmPasswordPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    func bindData() {
        if let model = registerModel {
            if let password = model.password {
                self.textField.text = password
            }
            
            if let confirmedPassword = model.confirmedPassword, let password = model.password {
                if confirmedPassword != password {
                    
                }
            }
        }
    }
    
    private func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        //"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    @IBAction func showHidePasswordAction(_ sender: Any) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
}

extension RegisterPasswordTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 100:
            if let password = textField.text, !password.isEmpty {
                if isValidPassword(password: password) {
                    errorView.hideView()
                    passwordContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
                    delegate?.passwordChanged(password: textField.text ?? "")
                } else {
                    errorView.showView()
                    errorLable.text = L10n.Validation.invalidPasswordFormate
                    passwordContainerView.layer.borderColor = UIColor.statusRed.cgColor
                }
            } else {
                errorView.showView()
                errorLable.text = L10n.Validation.requiredField
                passwordContainerView.layer.borderColor = UIColor.statusRed.cgColor
            }
        case 101:
            if let confirmedPassword = textField.text, !confirmedPassword.isEmpty {
                delegate?.confirmedPasswordChanged(confirmedPassword: textField.text ?? "")
                if let model = registerModel {
                    if let confirmedPassword = model.confirmedPassword, let password = model.password {
                        if confirmedPassword != password {
                            errorView.showView()
                            errorLable.text = L10n.Validation.passwordNotMatch
                            passwordContainerView.layer.borderColor = UIColor.statusRed.cgColor
                            return
                        }
                    }
                }

                if isValidPassword(password: confirmedPassword) {
                    errorView.hideView()
                    passwordContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
                    delegate?.passwordChanged(password: textField.text ?? "")
                } else {
                    errorView.showView()
                    errorLable.text = L10n.Validation.invalidPasswordFormate
                    passwordContainerView.layer.borderColor = UIColor.statusRed.cgColor
                }
            } else {
                errorView.showView()
                errorLable.text = L10n.Validation.requiredField
                passwordContainerView.layer.borderColor = UIColor.statusRed.cgColor
            }
        default:
            return
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

