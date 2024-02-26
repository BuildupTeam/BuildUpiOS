//
//  RejectedProductTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/02/2024.
//

import UIKit

class RejectedProductTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeightConstrains: NSLayoutConstraint!
    
    @IBOutlet private weak var productImageView: UIImageView!

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    
    var productModel: ProductModel? {
        didSet {
            bindData()
            self.tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    private func setupCell() {
        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCell()
        
        productNameLabel.font = .appFont(ofSize: 15, weight: .medium)
        productDescriptionLabel.font = .appFont(ofSize: 13, weight: .regular)

        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productDescriptionLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
      
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
       
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
    }
    
    private func registerTableViewCell() {
        self.tableView.register(
            UINib(nibName: ProductCombinationsOptionTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductCombinationsOptionTableViewCell.identifier)
    }
    
    private func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name ?? ""
            productDescriptionLabel.text = (model.productDescription ?? "")

            let tableViewHeight = CGFloat((model.cartCombinations?.first?.options?.count ?? 0) * 25)
            if tableViewHeight < 40 {
                tableViewHeightConstrains.constant = 40
            } else {
                tableViewHeightConstrains.constant = tableViewHeight
            }
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
}

// MARK: - TableView Delegate & DataSource
extension RejectedProductTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count = \(self.productModel?.cartCombinations?.first?.options?.count ?? 0)")
        return self.productModel?.cartCombinations?.first?.options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCombinationsOptionTableViewCell.identifier,
            for: indexPath) as? ProductCombinationsOptionTableViewCell
        else { return UITableViewCell() }
        
        if let option = self.productModel?.cartCombinations?.first?.options?[indexPath.row] {
            cell.cartOptionModel = option
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
