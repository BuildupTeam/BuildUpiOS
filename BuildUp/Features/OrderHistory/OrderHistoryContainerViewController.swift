//
//  OrderHistoryContainerViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import UIKit
import CarbonKit

class OrderHistoryContainerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCarbotKit()
    }
    
    private func setupView() {
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func setupCarbotKit() {
        let items = [L10n.Orders.current, L10n.Orders.past]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        
        carbonTabSwipeNavigation.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        carbonTabSwipeNavigation.toolbar.backgroundColor = .clear
        carbonTabSwipeNavigation.setIndicatorHeight(2)
        carbonTabSwipeNavigation.setTabBarHeight(50)//tab bar height
        
        carbonTabSwipeNavigation.setIndicatorColor(ThemeManager.colorPalette?.tabsActiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsActiveBorder ?? ""))
        
        let normalColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "") ?? UIColor.gray
        let selectedColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "") ?? UIColor.gray
        
        carbonTabSwipeNavigation.setNormalColor(normalColor, font: UIFont.appFont(ofSize: 15, weight: .regular))
        carbonTabSwipeNavigation.setSelectedColor(selectedColor, font: UIFont.appFont(ofSize: 15, weight: .medium))
        
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        var frameRect: CGRect = (carbonTabSwipeNavigation.carbonSegmentedControl?.frame) ?? CGRect()
        frameRect.size.width = UIScreen.main.bounds.size.width
//        frameRect.origin.x = self.view.center.x
        carbonTabSwipeNavigation.carbonSegmentedControl?.frame = frameRect
        carbonTabSwipeNavigation.carbonSegmentedControl?.apportionsSegmentWidthsByContent = false
        carbonTabSwipeNavigation.pagesScrollView?.isScrollEnabled = true
    }
}

extension OrderHistoryContainerViewController: CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(
        _ carbonTabSwipeNavigation: CarbonTabSwipeNavigation,
        viewControllerAt index: UInt) -> UIViewController {
        if index == 0 {
            return PastOrdersViewController()
        } else {
            return CurrentOrdersViewController()
        }
    }
}
