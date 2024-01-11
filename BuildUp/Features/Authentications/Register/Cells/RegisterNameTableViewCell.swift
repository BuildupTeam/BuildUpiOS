//
//  RegisterNameTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import UIKit

protocol RegisterCellDelegate: AnyObject {
    func countryCodeButtonClicked()
    func nameChanged(name: String)
    func emailChanged(email: String)
    func phoneChanged(phone: String)
    func countryCodeChanged(countryCode: String)
    func passwordChanged(password: String)
    func confirmedPasswordChanged(confirmedPassword: String)
}

class RegisterNameTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nameContainerView: UIView!
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
    
    var checkoutModel: CheckoutModel? {
        didSet {
            bindCheckoutData()
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
        titleLable.text = L10n.Register.name
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        titleLable.font = .appFont(ofSize: 14, weight: .medium)
        
        nameContainerView.layer.cornerRadius = 8
        nameContainerView.layer.masksToBounds = true
        nameContainerView.layer.borderWidth = 1
        nameContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        errorView.hideView()
        errorLable.text = L10n.Validation.requiredField
        errorLable.textColor = UIColor.statusRed
        errorLable.font = .appFont(ofSize: 12, weight: .regular)
        
        textField.delegate = self
        textField.showDoneButtonOnKeyboard()
        textField.returnKeyType = .done
        textField.backgroundColor = .clear
        textField.keyboardType = .default
        
        textField.setPlaceholder(
            placeholder: "\(L10n.Register.namePlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    func bindData() {
        if let model = registerModel {
            if let name = model.name {
                self.textField.text = name
            }
        }
    }
    
    func bindCheckoutData() {
        if let model = checkoutModel {
            if let name = model.name {
                self.textField.text = name
            }
        }
    }
    
    private func bindUserData() {
        if let model = editProfileModel {
            if let name = model.fullName {
                self.textField.text = name
            }
        }
    }
    
}

extension RegisterNameTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = textField.text, !name.isEmpty {
            errorView.hideView()
            nameContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
            delegate?.nameChanged(name: textField.text ?? "")
        } else {
            errorView.showView()
            nameContainerView.layer.borderColor = UIColor.statusRed.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
