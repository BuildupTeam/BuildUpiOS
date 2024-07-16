//
//  DeleteAccountPopupViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/07/2024.
//

import UIKit
import PanModal

protocol DeleteAccountPopupProtocol: AnyObject {
    func deleteAccountButtonClicked()
}

class DeleteAccountPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!
    @IBOutlet weak var deleteAccountImageView: UIImageView!
    
    weak var delegate: DeleteAccountPopupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        titleLabel.text = L10n.Popups.deleteAccount
        titleLabel.textAlignment = .center
        titleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        deleteAccountButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        deleteAccountButton.setTitle(L10n.Popups.confirmDeleteAccount, for: .normal)
        deleteAccountButton.setTitleColor(ThemeManager.colorPalette?.cardBg1?.toUIColor(hexa: ThemeManager.colorPalette?.cardBg1 ?? "") , for: .normal)
        deleteAccountButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        cancelButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        cancelButton.setTitle(L10n.Popups.cancel, for: .normal)
        cancelButton.setTitleColor(ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "") , for: .normal)
        cancelButton.backgroundColor = ThemeManager.colorPalette?.cardBg1?.toUIColor(hexa: ThemeManager.colorPalette?.cardBg1 ?? "")
        
        deleteAccountImageView.image = Asset.icLogout.image.withRenderingMode(.alwaysTemplate)
        deleteAccountImageView.tintColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = ThemeManager.colorPalette?.buttonBorderColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderColor ?? "").cgColor
        
        ThemeManager.setCornerRadious(element: deleteAccountButton, radius: 2)
        ThemeManager.setCornerRadious(element: cancelButton, radius: 2)
    }
    
    @IBAction func deleteAccountAction(_ sender: UIButton) {
        delegate?.deleteAccountButtonClicked()
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }

}

// MARK: PanModel Delegate
extension DeleteAccountPopupViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(CGFloat(340))
    }
    
    var shortFormHeight: PanModalHeight {
        return longFormHeight
    }
    
    var showDragIndicator: Bool {
        return false
    }
}
