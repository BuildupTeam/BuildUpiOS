//
//  ProductDetailsSliderType2TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import UIKit
import Cosmos
import SCPageControl

class ProductDetailsSliderType2TableViewCell: UITableViewCell {

    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var addToFavoriteSeparatedView: UIView!
    @IBOutlet private weak var addToFavoriteGroupedView: UIView!
    @IBOutlet private weak var productOutOfStockView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var seperatorView: UIView!
    @IBOutlet private weak var pageControlView: UIView!
    @IBOutlet private weak var productOldPriceMarkedView: UIView!

    @IBOutlet private weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var addToFavoriteImage: UIImageView!

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productOutOfStockLabel: UILabel!
    
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var cartButton: UIButton!
    
    weak var delegate: ProductDetailsSliderDelegate?
    
    let scPageControl = SCPageControlView()

    var productModel: ProductModel? {
        didSet {
            bindData()
            for view in scPageControl.subviews {
                view.removeFromSuperview()
            }
            if !(productModel?.files?.isEmpty ?? false) {
                scPageControl.set_view(productModel?.files?.count ?? 0,
                                       current: 0,
                                       current_color: ThemeManager.colorPalette?.indicatorActiveColor?.toUIColor(hexa: ThemeManager.colorPalette?.indicatorActiveColor ?? "") ?? .backgroundLightGray,
                                       scNormal_width: 15,
                                       scNormal_height: 10)
                self.collectionView.reloadData()
                collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.collectionView.reloadData()
                }
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
}
// MARK: - Private Func
extension ProductDetailsSliderType2TableViewCell {
    private func setupCell() {
        registerCollectionViewCells()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupPageControl()

//        containerViewHeightConstraint.constant = 540
        
        productNameLabel.font = .appFont(ofSize: 20, weight: .semiBold)
        productDescriptionLabel.font = .appFont(ofSize: 14, weight: .semiBold)
        productOutOfStockLabel.font = .appFont(ofSize: 12, weight: .medium)
        productOldPriceLabel.font = .appFont(ofSize: 14, weight: .medium)
        productNewPriceLabel.font = .appFont(ofSize: 17, weight: .medium)

        productNameLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productDescriptionLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        productOutOfStockLabel.textColor = ThemeManager.colorPalette?.tabsTextInactive?.toUIColor(hexa: ThemeManager.colorPalette?.tabsTextInactive ?? "")
        
        productOldPriceMarkedView.backgroundColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
        addToFavoriteSeparatedView.backgroundColor = ThemeManager.colorPalette?.favouriteBg?.toUIColor(hexa: ThemeManager.colorPalette?.favouriteBg ?? "")
        addToFavoriteSeparatedView.layer.masksToBounds = true
        addToFavoriteSeparatedView.layer.cornerRadius = addToFavoriteSeparatedView.frame.width / 2
        
        productOutOfStockView.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBg?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBg ?? "")
        productOutOfStockView.layer.masksToBounds = true
        productOutOfStockView.layer.cornerRadius = 4
        
        addToFavoriteGroupedView.layer.masksToBounds = true
        addToFavoriteGroupedView.layer.cornerRadius = 8
        
    }
    
    private func setupPageControl() {
        pageControlView.backgroundColor = .clear
        scPageControl.frame = CGRect(x: 0,
                                     y: pageControlView.bounds.minY,
                                     width: UIScreen.main.bounds.size.width,
                                     height: 20)
        
        scPageControl.scp_style = .SCNormal

        pageControlView.addSubview(scPageControl)
        
//        if LocalizationManager.isRTLdirection() {
//            pageControlView.transform = CGAffineTransform(scaleX: -1, y: 1)
//        }
    }
    
    private func setupCosmosView() {
        cosmosView.rating = 0
        cosmosView.settings.filledColor = .black
        cosmosView.settings.emptyBorderColor = .black
        cosmosView.settings.emptyBorderWidth = 1.5
        cosmosView.didFinishTouchingCosmos = didFinishTouchingCosmos(_:)
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
            
            if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
                if settings.actions == ProductDetailsActions.grouped.rawValue {
                    addToFavoriteSeparatedView.isHidden = true
                    addToFavoriteGroupedView.isHidden = false
                } else {
                    addToFavoriteSeparatedView.isHidden = false
                    addToFavoriteGroupedView.isHidden = true
                }
                
                if settings.variants == ProductDetailsVarianrs.variants3.rawValue {
                    seperatorView.backgroundColor = .clear
                }
            }
            
            if let quantity = model.quantity, quantity > 0 {
                productOutOfStockView.isHidden = true
            } else {
                productOutOfStockView.isHidden = false
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
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductDetailsSliderType2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductDetailsSliderType2CollectionViewCell.identifier)
    }
}

// MARK: - Actions
extension ProductDetailsSliderType2TableViewCell {
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
    
}

// MARK: - CollectionView Delegate && DataSource
extension ProductDetailsSliderType2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                withReuseIdentifier: ProductDetailsSliderType2CollectionViewCell.identifier,
                for: indexPath) as? ProductDetailsSliderType2CollectionViewCell else { return UICollectionViewCell() }
            
            if let model = productModel, !(model.files?.isEmpty ?? false) {
                cell.productFileModel = model.files?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        delegate?.homeCityTapped(cityModel: cities[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scPageControl.scroll_did(collectionView)
    }
}

// MARK: - Cosmos Delegate
extension ProductDetailsSliderType2TableViewCell {
    private func didFinishTouchingCosmos(_ rating: Double) {
//        ratingModel.rating = Int(rating)
//        validateData()
    }
}
