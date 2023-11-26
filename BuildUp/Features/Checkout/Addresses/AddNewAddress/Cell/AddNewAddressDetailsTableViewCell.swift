//
//  AddNewAddressDetailsTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import UIKit

protocol AddNewAddressDetailsDelegate: AnyObject {
    func addressChanged(address: String)
}

class AddNewAddressDetailsTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var addressContainerView: UIView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    weak var delegate: AddNewAddressDetailsDelegate?
    
    var detailedAddress: String? {
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
        titleLable.text = L10n.Checkout.detailedAddress
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        titleLable.font = .appFont(ofSize: 13, weight: .medium)
        
        addressContainerView.layer.cornerRadius = 8
        addressContainerView.layer.masksToBounds = true
        addressContainerView.layer.borderWidth = 1
        addressContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        textField.delegate = self
        textField.showDoneButtonOnKeyboard()
        textField.returnKeyType = .done
        textField.backgroundColor = .clear
        textField.keyboardType = .default
        textField.setPlaceholder(
            placeholder: "\(L10n.Checkout.detailedAddressPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    private func bindData() {
        textField.text = detailedAddress
    }
}

extension AddNewAddressDetailsTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.addressChanged(address: textField.text ?? "")
        /*
        if let name = textField.text, !name.isEmpty {
            errorView.hideView()
            nameContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
            delegate?.nameChanged(name: textField.text ?? "")
        } else {
            errorView.showView()
            nameContainerView.layer.borderColor = UIColor.statusRed.cgColor
        }
         */
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
