//
//  ProductDetailsSliderType1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import UIKit
import Cosmos

protocol ProductDetailsSliderDelegate: AnyObject {
    func seeMoreButtonClicked()
}

class ProductDetailsSliderType1TableViewCell: UITableViewCell {

    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var addToFavoriteSeparatedView: UIView!
    @IBOutlet private weak var addToFavoriteGroupedView: UIView!
    @IBOutlet private weak var productOutOfStockView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var seperatorView: UIView!
    @IBOutlet private weak var productOldPriceMarkedView: UIView!

    @IBOutlet private weak var addToFavoriteImage: UIImageView!
    @IBOutlet private weak var productImageView: UIImageView!

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productOutOfStockLabel: UILabel!
    @IBOutlet private weak var productRatingLabel: UILabel!

    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var cartButton: UIButton!
    @IBOutlet private weak var addToFavoriteButton: UIButton!    

    weak var delegate: ProductDetailsSliderDelegate?
    
    var productModel: ProductModel? {
        didSet {
            bindData()
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
//        setupCosmosView()
        registerCollectionViewCells()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        productNameLabel.font = .appFont(ofSize: 20, weight: .semiBold)
        productDescriptionLabel.font = .appFont(ofSize: 14, weight: .regular)
        productOldPriceLabel.font = .appFont(ofSize: 14, weight: .medium)
        productNewPriceLabel.font = .appFont(ofSize: 17, weight: .medium)
        productOutOfStockLabel.font = .appFont(ofSize: 12, weight: .medium)

        productNameLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        productDescriptionLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productOutOfStockLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
        productOldPriceMarkedView.backgroundColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
                
        addToFavoriteSeparatedView.backgroundColor = ThemeManager.colorPalette?.favouriteBg?.toUIColor(hexa: ThemeManager.colorPalette?.favouriteBg ?? "")
        addToFavoriteSeparatedView.layer.masksToBounds = true
        addToFavoriteSeparatedView.layer.cornerRadius = addToFavoriteSeparatedView.frame.size.width / 2
        
        addToFavoriteGroupedView.backgroundColor = ThemeManager.colorPalette?.navButtonBgColor?.toUIColor(hexa: ThemeManager.colorPalette?.navButtonBgColor ?? "")
        addToFavoriteGroupedView.layer.masksToBounds = true
        addToFavoriteGroupedView.layer.cornerRadius = 16
        
        productOutOfStockView.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBg?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBg ?? "")
//        productOutOfStockView.layer.masksToBounds = true
//        productOutOfStockView.layer.cornerRadius = 4
        
        ThemeManager.setCornerRadious(element: productOutOfStockView, radius: 4)
    }
    
    private func setupCosmosView() {
        cosmosView.rating = 0
        cosmosView.settings.filledColor = .black
        cosmosView.settings.emptyBorderColor = .black
        cosmosView.settings.emptyBorderWidth = 1.5
        cosmosView.didFinishTouchingCosmos = didFinishTouchingCosmos(_:)
    }
    
    private func setTitle() {
//        guard let title = self.title else { return }
//        let attributeString = NSMutableAttributedString(string: title)
//        if let titleFont = font {
//            attributeString.addAttributes([NSAttributedString.Key.font: titleFont],
//                                          range: NSMakeRange(0, title.utf8.count))
//        }
//
//        if let titleColor = color {
//            attributeString.addAttributes([NSAttributedString.Key.foregroundColor: titleColor], range: NSMakeRange(0, title.utf8.count))
//        }
//        self.setValue(attributeString, forKey: "attributedTitle")
    }
    
    private func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name ?? ""
            productDescriptionLabel.text = (model.productDescription ?? "")//.maxLength(length: 69)
            productOldPriceLabel.text = "SAR " + String(model.originalPrice ?? 0)
            productNewPriceLabel.text = "SAR " + String(model.currentPrice ?? 0)
            
            if !model.descriptionIsExpaned {
                if let desc = model.productDescription, desc.count > 40 {
                    productDescriptionLabel.text = desc//.maxLength(length: 70)
                    
                    let readmoreFont = UIFont.appFont(ofSize: 14, weight: .bold)
                    let readmoreFontColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "") ?? UIColor.titlesBlack
                    DispatchQueue.main.async {
                        self.productDescriptionLabel.addTrailing(with: "... ", moreText: L10n.ProductDetails.readMore, moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
                    }
                } else {
                    productDescriptionLabel.text = model.productDescription ?? ""
                }
            }
            
            if let quantity = model.quantity, quantity > 0 {
                productOutOfStockView.isHidden = true
            } else {
                productOutOfStockView.isHidden = false
            }
            
            if let fileModel = model.files?.first {
                if let imageUrl = fileModel.path {
                    productImageView.setImage(with: imageUrl)
                } else {
                    productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
                }
            }
            
            if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
                if settings.actions == ProductDetailsActions.grouped.rawValue {
                    addToFavoriteSeparatedView.isHidden = true
                    addToFavoriteGroupedView.isHidden = false
                } else {
                    addToFavoriteSeparatedView.isHidden = false
                    addToFavoriteGroupedView.isHidden = true
                }
                
                if settings.variants != ProductDetailsVarianrs.variants1.rawValue {
                    seperatorView.backgroundColor = .clear
                }
            }
            
            if (model.discount ?? 0) > 0 {
                productOldPriceLabel.isHidden = false
                productOldPriceMarkedView.isHidden = false
            } else {
                productOldPriceLabel.isHidden = true
                productOldPriceMarkedView.isHidden = true
            }
            
            if model.isFavorite {
                self.addToFavoriteImage.image = Asset.productFavorite.image
            } else {
                self.addToFavoriteImage.image = Asset.productUnFavorite.image
            }
        }
    }
    
    @IBAction func seeMoreButtonClicked(_ sender: UIButton) {
        if let model = productModel {
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
            UINib(nibName: ProductDetailsSliderType1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductDetailsSliderType1CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension ProductDetailsSliderType1TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                withReuseIdentifier: ProductDetailsSliderType1CollectionViewCell.identifier,
                for: indexPath) as? ProductDetailsSliderType1CollectionViewCell else { return UICollectionViewCell() }
            
            if let model = productModel, !(model.files?.isEmpty ?? false) {
                cell.productFileModel = model.files?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76, height: 76)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let files = self.productModel?.files, !files.isEmpty {
            for file in files {
                file.isSelected = false
            }
        }
            
        if let fileModel = productModel?.files?[indexPath.row] {
            fileModel.isSelected = true
            self.collectionView.reloadData()
            if let imageUrl = fileModel.path {
                productImageView.setImage(with: imageUrl)
            }
        }
    }
}

// MARK: - Cosmos Delegate
extension ProductDetailsSliderType1TableViewCell {
    private func didFinishTouchingCosmos(_ rating: Double) {
//        ratingModel.rating = Int(rating)
//        validateData()
    }
}

