//
//  CheckoutPaymentViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit

class CheckoutPaymentViewController: BaseViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var checkView: UIView!
    @IBOutlet private weak var headerView: CheckoutStatusView!
    @IBOutlet private weak var onlinePaymentLabel: UILabel!
    @IBOutlet private weak var cashLabel: UILabel!
    @IBOutlet private weak var choosePaymentLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!

    override  var prefersBottomBarHidden: Bool? { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = L10n.Checkout.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
    
    private func setupView() {
        headerView.setupView()
        headerView.setupPaymentView()
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        choosePaymentLabel.text = L10n.Checkout.choosePayment
        cashLabel.text = L10n.Checkout.cashOnDelivery
        onlinePaymentLabel.text = L10n.Checkout.onlinePayement
        
        choosePaymentLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        cashLabel.font = .appFont(ofSize: 13, weight: .medium)
        onlinePaymentLabel.font = .appFont(ofSize: 13, weight: .medium)
        
        choosePaymentLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        cashLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        onlinePaymentLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 8
        continueButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        continueButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        continueButton.setTitle(L10n.Checkout.continue, for: .normal)
        continueButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        checkView.layer.masksToBounds = true
        checkView.layer.cornerRadius = checkView.frame.size.width / 2
        checkView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
    }

}
