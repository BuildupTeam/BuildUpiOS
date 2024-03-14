//
//  LogoutPopupViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/01/2024.
//

import UIKit
import PanModal

protocol LogoutPopupProtocol: AnyObject {
    func logoutButtonClicked()
}

class LogoutPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var logoutImageView: UIImageView!
    
    weak var delegate: LogoutPopupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        titleLabel.text = L10n.Popups.logoutMsg
        titleLabel.textAlignment = .center
        titleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        logoutButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        logoutButton.setTitle(L10n.Popups.logout, for: .normal)
        logoutButton.setTitleColor(ThemeManager.colorPalette?.cardBg1?.toUIColor(hexa: ThemeManager.colorPalette?.cardBg1 ?? "") , for: .normal)
        logoutButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        cancelButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        cancelButton.setTitle(L10n.Popups.cancel, for: .normal)
        cancelButton.setTitleColor(ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "") , for: .normal)
        cancelButton.backgroundColor = ThemeManager.colorPalette?.cardBg1?.toUIColor(hexa: ThemeManager.colorPalette?.cardBg1 ?? "")
        
        logoutImageView.image = Asset.icLogout.image.withRenderingMode(.alwaysTemplate)
        logoutImageView.tintColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = ThemeManager.colorPalette?.buttonBorderColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderColor ?? "").cgColor
        
        ThemeManager.setCornerRadious(element: logoutButton, radius: 2)
        ThemeManager.setCornerRadious(element: cancelButton, radius: 2)
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        delegate?.logoutButtonClicked()
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: PanModel Delegate
extension LogoutPopupViewController: PanModalPresentable {
    
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
