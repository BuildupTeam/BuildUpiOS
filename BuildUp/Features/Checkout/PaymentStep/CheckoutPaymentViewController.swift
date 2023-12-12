//
//  CheckoutPaymentViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit

class CheckoutPaymentViewController: BaseViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var cashCheckView: UIView!
    @IBOutlet private weak var onlineCheckView: UIView!
    @IBOutlet private weak var headerView: CheckoutStatusView!
    @IBOutlet private weak var onlinePaymentLabel: UILabel!
    @IBOutlet private weak var cashLabel: UILabel!
    @IBOutlet private weak var choosePaymentLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!
    
    override  var prefersBottomBarHidden: Bool? { return true }

    var checkoutModel: CheckoutModel?

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
        
        cashCheckView.showView()
        onlineCheckView.hideView()
        
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 8
        continueButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        continueButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        continueButton.setTitle(L10n.Checkout.continue, for: .normal)
        continueButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        cashCheckView.layer.masksToBounds = true
        cashCheckView.layer.cornerRadius = cashCheckView.frame.size.width / 2
        cashCheckView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
        
        onlineCheckView.layer.masksToBounds = true
        onlineCheckView.layer.cornerRadius = onlineCheckView.frame.size.width / 2
        onlineCheckView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
    }
}

// MARK: Actions
extension CheckoutPaymentViewController {
    @IBAction func cashPaymentAction(_ sender: UIButton) {
        cashCheckView.showView()
        onlineCheckView.hideView()
        
        checkoutModel?.paymentMethod = "cod"
    }
    
    @IBAction func onlinePaymentAction(_ sender: UIButton) {
        cashCheckView.hideView()
        onlineCheckView.showView()
        checkoutModel?.paymentMethod = "paytabs"
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
//        self.showLoading()
        let checkoutReviewVC = Coordinator.Controllers.createCheckoutReviewViewController()
        checkoutReviewVC.checkoutModel = self.checkoutModel
        self.navigationController?.pushViewController(checkoutReviewVC, animated: true)
    }
}
