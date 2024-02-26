//
//  RejectedProductsViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/02/2024.
//

import UIKit

protocol RejectedProductsDelegate: AnyObject {
    func backToCartButtonClicked()
}

class RejectedProductsViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var outOfStockLabel: UILabel!
    @IBOutlet private weak var runOutOfStockLabel: UILabel!
    @IBOutlet private weak var backToCartButton: UIButton!
    
    var products: [ProductModel]?
    weak var delegate: RejectedProductsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        registerTableViewCell()
        
        outOfStockLabel.text = L10n.Checkout.outOfStock
        runOutOfStockLabel.text = L10n.Checkout.runsOutOfStock
        
        outOfStockLabel.textAlignment = .center
        runOutOfStockLabel.textAlignment = .center
        
        outOfStockLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        runOutOfStockLabel.font = .appFont(ofSize: 13, weight: .semiBold)

        outOfStockLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        runOutOfStockLabel.textColor = ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? "")
        
        backToCartButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        backToCartButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        backToCartButton.setTitle(L10n.Checkout.backToCart, for: .normal)
        backToCartButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        ThemeManager.setCornerRadious(element: backToCartButton, radius: 8)
    }

    private func registerTableViewCell() {
        self.tableView.register(
            UINib(nibName: RejectedProductTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: RejectedProductTableViewCell.identifier)
    }
    
    @IBAction func backToCartAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        delegate?.backToCartButtonClicked()
    }
}

// MARK: - TableView Delegate & DataSource
extension RejectedProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RejectedProductTableViewCell.identifier,
            for: indexPath) as? RejectedProductTableViewCell
        else { return UITableViewCell() }
        
        cell.productModel = products?[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
}
