//
//  RegisterPhoneTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import UIKit
import PhoneNumberKit

class RegisterPhoneTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var phoneContainerView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var countryFlagImageView: UIImageView!
    @IBOutlet private weak var seperatorView: UIView!
    
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var errorLable: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    weak var delegate: RegisterCellDelegate?

    var registerModel: RegisterModel? {
        didSet {
            bindData()
        }
    }
    
    var checkoutModel: CheckoutModel? {
        didSet {
            bindCheckoutData()
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
        titleLable.text = L10n.Register.phone
        titleLable.font = .appFont(ofSize: 14, weight: .medium)
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        phoneContainerView.layer.cornerRadius = 8
        phoneContainerView.layer.masksToBounds = true
        phoneContainerView.layer.borderWidth = 1
        phoneContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        errorLable.font = .appFont(ofSize: 12, weight: .regular)
        errorLable.text = L10n.Validation.requiredField
        errorLable.textColor = UIColor.statusRed
        //ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
        errorView.hideView()
        
        textField.delegate = self
        textField.showDoneButtonOnKeyboard()
        textField.returnKeyType = .done
        textField.backgroundColor = .clear
        textField.keyboardType = .asciiCapableNumberPad
        
        textField.setPlaceholder(
            placeholder: "\(L10n.Register.phonePlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    func bindData() {
        if let model = registerModel {
            if let flag = model.countryFlag {
                self.countryFlagImageView.image = flag
            }
            if let phone = model.phone {
                self.textField.text = phone
            }
        }
    }
    
    func bindCheckoutData() {
        if let model = checkoutModel {
            if let flag = model.countryFlag {
                self.countryFlagImageView.image = flag
            }
            if let phone = model.phone {
                self.textField.text = phone
            }
        }
    }
    
    func isMobileNumberValid(phone: String) -> Bool {
        var countryCode = registerModel?.countryCode
        if countryCode == nil {
            countryCode = checkoutModel?.countryCode
        }

        let phoneNumberKit = PhoneNumberKit()
        do {
            _ = try phoneNumberKit.parse((countryCode ?? "") + phone)
            errorView.hideView()
            phoneContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
            return true
        } catch {
            errorView.showView()
            phoneContainerView.layer.borderColor = UIColor.statusRed.cgColor
            errorLable.text = L10n.Validation.invalidMobileNumber
            errorLable.textColor = UIColor.statusRed
            return false
        }
    }
    
    private func validateMobileNumber(phone: String) {
        let isValid = isMobileNumberValid(phone: phone)
        if isValid {
            delegate?.phoneChanged(phone: phone)
        }
    }
    
    @IBAction func countryCodeAction(_ sender: UIButton) {
        delegate?.countryCodeButtonClicked()
    }
}

extension RegisterPhoneTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let phone = textField.text, !phone.isEmpty {
            validateMobileNumber(phone: phone)
        } else {
            errorView.showView()
            errorLable.text = L10n.Validation.requiredField
            phoneContainerView.layer.borderColor = UIColor.statusRed.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
