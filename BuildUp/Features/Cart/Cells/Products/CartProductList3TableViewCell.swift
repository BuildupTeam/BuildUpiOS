//
//  CartProductList3TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

class CartProductList3TableViewCell: UITableViewCell {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productOldPriceMarkedView: UIView!
    @IBOutlet private weak var removeProductView: UIView!
    @IBOutlet private weak var tableViewHeightConstrains: NSLayoutConstraint!
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productQuantityLabel: UILabel!
    @IBOutlet private weak var removeProductLabel: UILabel!
    
    @IBOutlet private weak var removeProductButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    
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
extension CartProductList3TableViewCell {
    private func setupCell() {
        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCell()
        
        productNameLabel.font = .appFont(ofSize: 15, weight: .medium)
        productDescriptionLabel.font = .appFont(ofSize: 13, weight: .regular)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .extraBold)
        productNewPriceLabel.font = .appFont(ofSize: 15, weight: .extraBold)
        removeProductLabel.font = .appFont(ofSize: 12, weight: .medium)
        productQuantityLabel.font = .appFont(ofSize: 15, weight: .regular)

        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productDescriptionLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        removeProductLabel.textColor = ThemeManager.colorPalette?.buttonTextColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor4 ?? "")
        productQuantityLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        removeProductLabel.text = L10n.Cart.remove
        
        productOldPriceMarkedView.backgroundColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        removeProductView.layer.borderWidth = 1
        removeProductView.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
        
        plusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        minusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")

        if let model = productModel {
            checkIfCanMinusPlus(model: model)
        }

        ThemeManager.setCornerRadious(element: minusButton, radius: minusButton.frame.size.width / 2)
        ThemeManager.setCornerRadious(element: plusButton, radius: plusButton.frame.size.width / 2)
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
        ThemeManager.setCornerRadious(element: removeProductView, radius: 8)
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
            
            if let combinationModel = model.cartCombinations?.first {
                productOldPriceLabel.text = combinationModel.price?.formatted
                productNewPriceLabel.text = combinationModel.currentPrice?.formatted
            } else {
                productOldPriceLabel.text = model.originalPrice?.formatted
                productNewPriceLabel.text = model.formattedPrice?.formatted
            }
            
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
            if let combinationModel = model.cartCombinations?.first {
                let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: combinationModel.cartQuantity, combinationId: combinationModel.id)
                RealTimeDatabaseService.addProductModelFromCart(model: firebaseProductModel)
            } else {
                let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.cartQuantity)
                RealTimeDatabaseService.addProductModelFromCart(model: firebaseProductModel)
            }
        }
    }
    
    private func checkIfCanMinusPlus(model: ProductModel) {
        if (model.cartQuantity ?? 0) >= (model.getCartMaxQuantity()) {
            plusButton.isEnabled = false
            plusButton.backgroundColor = .white
            
            let grayPlusImage = Asset.plusWhite.image.withRenderingMode(.alwaysTemplate).sd_tintedImage(with: ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "") ?? .red)
            plusButton.setImage(grayPlusImage, for: .normal)
            
            plusButton.layer.borderWidth = 1
            plusButton.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
        } else {
            let grayPluImage = Asset.plusWhite.image
            plusButton.setImage(grayPluImage, for: .normal)
            
            plusButton.layer.borderWidth = 0
            plusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            plusButton.isEnabled = true
        }
        
        if (model.cartQuantity ?? 0) <= 1 {
            minusButton.backgroundColor = .white
            minusButton.isEnabled = false
            
            let grayMinusImage = Asset.icMinusWhite.image.withRenderingMode(.alwaysTemplate).sd_tintedImage(with: ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "") ?? .red)
            minusButton.setImage(grayMinusImage, for: .normal)
            
            minusButton.layer.borderWidth = 1
            minusButton.layer.borderColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "").cgColor
        } else {
            let grayMinusImage = Asset.icMinusWhite.image
            minusButton.setImage(grayMinusImage, for: .normal)
            
            minusButton.layer.borderWidth = 0
            minusButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            minusButton.isEnabled = true
        }
    }
}

// MARK: - @IBActions
extension CartProductList3TableViewCell {
    @IBAction func plusButtonAction(_ sender: UIButton) {
        if let model = productModel, var quantity = model.cartQuantityValue {
            if quantity >= 1 {
                if (quantity + 1 ) <= (model.getCartMaxQuantity()) {
                    quantity += 1
                }
            }
            
            if let combinationModel = model.cartCombinations?.first {
                model.cartCombinations?.first?.cartQuantity = quantity
            } else {
                model.cartQuantity = quantity
            }
            
            productQuantityLabel.text = String(quantity)
            delegate?.quantityChanged(quantity: quantity, model: model)
            
            checkIfCanMinusPlus(model: model)
            addToCartFirebase()
        }
        
    }
    
    @IBAction func minusButtonAction(_ sender: UIButton) {
        if let model = productModel, var quantity = model.cartQuantityValue {
            if quantity > 1 {
                quantity -= 1
            }
            
            if let combinationModel = model.cartCombinations?.first {
                model.cartCombinations?.first?.cartQuantity = quantity
            } else {
                model.cartQuantity = quantity
            }
            
            productQuantityLabel.text = String(quantity)
            delegate?.quantityChanged(quantity: quantity, model: model)
            
            checkIfCanMinusPlus(model: model)
            addToCartFirebase()
        }
    }
    
    @IBAction func removeProductAction(_ sender: UIButton) {
        if let model = self.productModel {
            if let combinationId = model.cartCombinations?.first?.id {
                let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.quantitySelected, combinationId: combinationId)
                RealTimeDatabaseService.removeProductModelFromCart(model: firebaseProductModel)
            } else {
                let firebaseProductModel = FirebaseProductModel(uuid: model.uuid, quantity: model.cartQuantity)
                RealTimeDatabaseService.removeProductModelFromCart(model: firebaseProductModel)
            }
            
            delegate?.removeButtonClicked(model: model)
        }
    }
}

// MARK: - TableView Delegate & DataSource
extension CartProductList3TableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count = \(self.productModel?.cartCombinations?.first?.options?.count ?? 0)")
        return self.productModel?.cartCombinations?.first?.options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCombinationsOptionTableViewCell.identifier,
            for: indexPath) as? ProductCombinationsOptionTableViewCell
        else { return UITableViewCell() }
        
        cell.cartOptionModel = self.productModel?.cartCombinations?.first?.options?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
