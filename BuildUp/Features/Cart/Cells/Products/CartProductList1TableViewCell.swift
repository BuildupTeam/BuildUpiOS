//
//  CartProductList1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

protocol CartProductListDelegate: AnyObject {
    func quantityChanged(quantity: Int, model: ProductModel)
    func removeButtonClicked(model: ProductModel)
}

class CartProductList1TableViewCell: UITableViewCell {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productOldPriceMarkedView: UIView!
    @IBOutlet private weak var removeProductView: UIView!
    @IBOutlet private weak var addToWishListView: UIView!
    @IBOutlet private weak var productQuantityView: UIView!
    @IBOutlet private weak var tableViewHeightConstrains: NSLayoutConstraint!
    
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productQuantityLabel: UILabel!
    @IBOutlet private weak var addToWishListLabel: UILabel!
    @IBOutlet private weak var removeProductLabel: UILabel!

    @IBOutlet private weak var addToWishListButton: UIButton!
    @IBOutlet private weak var productQuantityButton: UIButton!
    @IBOutlet private weak var removeProductButton: UIButton!

    weak var delegate: CartProductListDelegate?
    
    var productModel: ProductModel? {
        didSet {
            bindData()
            self.tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
}

// MARK: - Private Func
extension CartProductList1TableViewCell {
    private func setupCell() {
        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCell()
        
        productNameLabel.font = .appFont(ofSize: 15, weight: .medium)
        productDescriptionLabel.font = .appFont(ofSize: 13, weight: .regular)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .extraBold)
        productNewPriceLabel.font = .appFont(ofSize: 15, weight: .extraBold)
        removeProductLabel.font = .appFont(ofSize: 12, weight: .medium)
        addToWishListLabel.font = .appFont(ofSize: 12, weight: .medium)
        productQuantityLabel.font = .appFont(ofSize: 15, weight: .regular)

        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productDescriptionLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        removeProductLabel.textColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "")
        addToWishListLabel.textColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "")
        productQuantityLabel.textColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "")
        
        addToWishListLabel.text = L10n.Cart.addWishList
        removeProductLabel.text = L10n.Cart.remove
        
        productOldPriceMarkedView.backgroundColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        removeProductView.layer.borderWidth = 1
        removeProductView.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
        
        addToWishListView.layer.borderWidth = 1
        addToWishListView.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
        
        productQuantityView.layer.borderWidth = 1
        productQuantityView.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor

        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
        ThemeManager.setCornerRadious(element: removeProductView, radius: 8)
        ThemeManager.setCornerRadious(element: addToWishListView, radius: 8)
        ThemeManager.setCornerRadious(element: productQuantityView, radius: 8)
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
            productOldPriceLabel.text = String(model.originalPrice ?? 0) + L10n.ProductDetails.currency
            productNewPriceLabel.text = String(model.currentPrice ?? 0) + L10n.ProductDetails.currency
            productQuantityLabel.text = String(model.cartQuantityValue ?? 0)

            let tableViewHeight = CGFloat((model.cartCombinations?.first?.options?.count ?? 0) * 25)
            if tableViewHeight < 40 {
                tableViewHeightConstrains.constant = 40
            } else {
                tableViewHeightConstrains.constant = tableViewHeight
            }
            
            if (model.discount ?? 0) > 0 {
                productOldPriceLabel.isHidden = false
                productOldPriceMarkedView.isHidden = false
            } else {
                productOldPriceLabel.isHidden = true
                productOldPriceMarkedView.isHidden = true
            }
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
    
    private func addToCartFirebase() {
        if let model = productModel {
            if let combinationId = model.cartCombinations?.first?.id {
                let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.quantitySelected, combinationId: combinationId)
                RealTimeDatabaseService.addProductModelFromCart(model: firebaseProductModel)
            } else {
                let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.quantitySelected)
                RealTimeDatabaseService.addProductModelFromCart(model: firebaseProductModel)
            }
        }
    }
}

// MARK: - @IBActions
extension CartProductList1TableViewCell {
    @IBAction func quantityActionButton(_ sender: UIButton) {
        var elements: [UIAction] = []
        guard let model = productModel else { return }
        
        let quantityCount = model.quantity ?? 0
                
        if quantityCount <= 1 {
            return
        }
        
        for i in (1 ... quantityCount) {
            let first = UIAction(title: String(i), image: UIImage(), attributes: [], state: .off) { action in
                print(String(i))
                self.productModel?.quantitySelected = i
                self.productQuantityLabel.text = String(i)
                self.delegate?.quantityChanged(quantity: i, model: model)
                self.addToCartFirebase()
            }
            elements.append(first)
        }
        
        let menu = UIMenu(title: L10n.ProductDetails.quantity, identifier: .alignment, options: .displayInline, children: elements)
        productQuantityButton.showsMenuAsPrimaryAction = true
        productQuantityButton.menu = menu
    }
    
    @IBAction func removeProductAction(_ sender: UIButton) {
        if let model = self.productModel {
            if let combinationId = model.cartCombinations?.first?.id {
                let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.quantitySelected, combinationId: combinationId)
                RealTimeDatabaseService.removeProductModelFromCart(model: firebaseProductModel)
            } else {
                let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.quantitySelected)
                RealTimeDatabaseService.removeProductModelFromCart(model: firebaseProductModel)
            }
            
            delegate?.removeButtonClicked(model: model)
        }
    }
}

// MARK: - TableView Delegate & DataSource
extension CartProductList1TableViewCell: UITableViewDelegate, UITableViewDataSource {
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
