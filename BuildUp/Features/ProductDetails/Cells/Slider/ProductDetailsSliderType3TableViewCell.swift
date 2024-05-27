//
//  ProductDetailsSliderType3TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import UIKit
import Cosmos

class ProductDetailsSliderType3TableViewCell: UITableViewCell {

    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var addToFavoriteView: UIView!
    @IBOutlet private weak var productOutOfStockView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var seperatorView: UIView!

    @IBOutlet private weak var addToFavoriteImage: UIImageView!

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productOutOfStockLabel: UILabel!
    @IBOutlet private weak var productRatingLabel: UILabel!

    weak var delegate: ProductDetailsSliderDelegate?
    
    var productModel: ProductModel? {
        didSet {
            bindData()
            if (productModel?.files?.count ?? 0 > 1) {
                self.collectionView.reloadData()
                self.collectionView.showView()
            } else {
                self.collectionView.hideView()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
//        setupCosmosView()
        registerCollectionViewCells()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        productOutOfStockLabel.text = L10n.Checkout.outOfStock
        
        productNameLabel.font = .appFont(ofSize: 20, weight: .semiBold)
        productDescriptionLabel.font = .appFont(ofSize: 14, weight: .regular)
//        productRatingLabel.font = .appFont(ofSize: 13, weight: .regular)
        productOutOfStockLabel.font = .appFont(ofSize: 12, weight: .semiBold)

        productNameLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        productDescriptionLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        productOutOfStockLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
        
        addToFavoriteView.backgroundColor = ThemeManager.colorPalette?.favouriteBg?.toUIColor(hexa: ThemeManager.colorPalette?.favouriteBg ?? "")
//        addToFavoriteView.layer.masksToBounds = true
//        addToFavoriteView.layer.cornerRadius = addToFavoriteView.frame.size.width / 2
        
        productOutOfStockView.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBg?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBg ?? "")
        productOutOfStockView.layer.masksToBounds = true
        productOutOfStockView.layer.cornerRadius = 4
        
        ThemeManager.setCornerRadious(element: addToFavoriteView, radius: addToFavoriteView.frame.size.width / 2)
//        ThemeManager.setCornerRadious(element: addToCartButton, radius: 15)
    }
    
    private func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name ?? ""
            productDescriptionLabel.text = model.productDescription ?? ""
            
            if let quantity = model.quantity, quantity > 0 {
                productOutOfStockView.isHidden = false
            } else {
                productOutOfStockView.isHidden = true
            }
        }
    }
    
    private func setupCosmosView() {
        cosmosView.rating = 0
        cosmosView.settings.filledColor = .black
        cosmosView.settings.emptyBorderColor = .black
        cosmosView.settings.emptyBorderWidth = 1.5
        cosmosView.didFinishTouchingCosmos = didFinishTouchingCosmos(_:)
    }
    
    @IBAction func seeMoreButtonClicked(_ sender: UIButton) {
        if var model = productModel {
            if !model.descriptionIsExpaned {
                self.productDescriptionLabel.numberOfLines = 0
                model.descriptionIsExpaned = true
                self.productDescriptionLabel.text = model.productDescription
            } else {
                self.productDescriptionLabel.numberOfLines = 2
                model.descriptionIsExpaned = false
            }
            
        }
        
        self.delegate?.seeMoreButtonClicked()
        self.sizeToFit()
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        if CachingService.getUser() == nil {
            delegate?.userIsNotLoggedIn()
            return
        }
        if let model = productModel {
            if model.isFavorite {
                self.addToFavoriteImage.image = Asset.productUnFavorite.image
            } else {
                self.addToFavoriteImage.image = Asset.productFavorite.image
            }
            let favoriteModel = FirebaseFavoriteModel(uuid: model.uuid ?? "", isFavorite: model.isFavorite,createdAt: (Date().timeIntervalSince1970 * 1000))
            RealTimeDatabaseService.favoriteUnfavoriteProduct(model: favoriteModel)
        }
    }
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductDetailsSliderType2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductDetailsSliderType2CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension ProductDetailsSliderType3TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = productModel, !(model.files?.isEmpty ?? false) {
            return model.files?.count ?? 0
        }
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductDetailsSliderType3CollectionViewCell.identifier,
                for: indexPath) as? ProductDetailsSliderType3CollectionViewCell else { return UICollectionViewCell() }
            
            if let model = productModel, !(model.files?.isEmpty ?? false) {
                cell.productFileModel = model.files?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth, height: 386)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        delegate?.homeCityTapped(cityModel: cities[indexPath.row])
    }
}

// MARK: - Cosmos Delegate
extension ProductDetailsSliderType3TableViewCell {
    private func didFinishTouchingCosmos(_ rating: Double) {
//        ratingModel.rating = Int(rating)
//        validateData()
    }
}
