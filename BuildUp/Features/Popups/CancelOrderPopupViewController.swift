//
//  CancelOrderPopupViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 28/02/2024.
//

import UIKit
import PanModal

protocol CancelOrderPopupProtocol: AnyObject {
    func cancelOrderClicked()
}

class CancelOrderPopupViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    weak var delegate: CancelOrderPopupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        titleLabel.text = L10n.Popups.cancelOrderMsg
        titleLabel.textAlignment = .center
        titleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        confirmButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        confirmButton.setTitle(L10n.Popups.confirm, for: .normal)
        confirmButton.setTitleColor(ThemeManager.colorPalette?.cardBg1?.toUIColor(hexa: ThemeManager.colorPalette?.cardBg1 ?? "") , for: .normal)
        confirmButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        cancelButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        cancelButton.setTitle(L10n.Popups.cancel, for: .normal)
        cancelButton.setTitleColor(ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "") , for: .normal)
        cancelButton.backgroundColor = ThemeManager.colorPalette?.cardBg1?.toUIColor(hexa: ThemeManager.colorPalette?.cardBg1 ?? "")
        
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = ThemeManager.colorPalette?.buttonBorderColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderColor ?? "").cgColor
        
        ThemeManager.setCornerRadious(element: confirmButton, radius: 2)
        ThemeManager.setCornerRadious(element: cancelButton, radius: 2)
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        delegate?.cancelOrderClicked()
        dismiss(animated: true)
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }

}

// MARK: PanModel Delegate
extension CancelOrderPopupViewController: PanModalPresentable {
    
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
