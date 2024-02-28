//
//  LoginPopupViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/01/2024.
//

import UIKit
import PanModal

protocol LoginPopupProtocol: AnyObject {
    func loginButtonClicked()
}

class LoginPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var seperatorView: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var delegate: LoginPopupProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        titleLabel.text = L10n.Popups.loginMsg
        titleLabel.textAlignment = .center
        titleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        loginButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        loginButton.setTitle(L10n.Popups.login, for: .normal)
        loginButton.setTitleColor(ThemeManager.colorPalette?.cardBg1?.toUIColor(hexa: ThemeManager.colorPalette?.cardBg1 ?? "") , for: .normal)
        loginButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        cancelButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        cancelButton.setTitle(L10n.Popups.cancel, for: .normal)
        cancelButton.setTitleColor(ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "") , for: .normal)
        cancelButton.backgroundColor = ThemeManager.colorPalette?.cardBg1?.toUIColor(hexa: ThemeManager.colorPalette?.cardBg1 ?? "")
        
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = ThemeManager.colorPalette?.buttonBorderColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderColor ?? "").cgColor
        
        ThemeManager.setCornerRadious(element: loginButton, radius: 2)
        ThemeManager.setCornerRadious(element: cancelButton, radius: 2)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        delegate?.loginButtonClicked()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: PanModel Delegate
extension LoginPopupViewController: PanModalPresentable {
    
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
