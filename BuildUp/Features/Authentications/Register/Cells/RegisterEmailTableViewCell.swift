//
//  RegisterEmailTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import UIKit

class RegisterEmailTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var emailContainerView: UIView!
    @IBOutlet private weak var errorView: UIView!
    
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var errorLable: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    weak var delegate: RegisterCellDelegate?

    var registerModel: RegisterModel? {
        didSet {
            bindData()
        }
    }
    
    var editProfileModel: EditProfileModel? {
        didSet {
            bindUserData()
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
        titleLable.text = L10n.Register.email
        titleLable.font = .appFont(ofSize: 14, weight: .medium)
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
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
    
    func bindData() {
        if let model = registerModel {
            if let email = model.email {
                self.textField.text = email
            }
        }
    }
    
    private func bindUserData() {
        if let model = editProfileModel {
            if let email = model.email {
                self.textField.text = email
            }
        }
    }
    
}

extension RegisterEmailTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let email = textField.text, !email.isEmpty {
            if isValidEmail(email) {
                errorView.hideView()
                emailContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
                delegate?.emailChanged(email: email)
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
