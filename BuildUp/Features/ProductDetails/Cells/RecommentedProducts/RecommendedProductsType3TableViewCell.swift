//
//  RecommendedProductsType3TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/09/2023.
//

import UIKit

class RecommendedProductsType3TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstrains: NSLayoutConstraint!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headerViewHeightContraints: NSLayoutConstraint!
    @IBOutlet private weak var containerViewHeightContraints: NSLayoutConstraint!
    @IBOutlet private weak var headerTitleLabel: UILabel!
    @IBOutlet private weak var headerSeeMoreButton: UIButton!
    
    weak var delegate: RecommentedProductsDelegate?

    var productModel: ProductModel? {
        didSet {
            self.bindData()
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {        
        registerCollectionViewCells()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = RTLCollectionFlow()
        if LocalizationManager.isRTLdirection() {
            collectionView.semanticContentAttribute = .forceRightToLeft
        }
        
        headerTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        headerTitleLabel.font = .appFont(ofSize: 17, weight: .semiBold)
        headerSeeMoreButton.titleLabel?.font = .appFont(ofSize: 13, weight: .semiBold)
        headerSeeMoreButton.setTitleColor(ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? ""), for: .normal)
        
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
            if ((settings.recommendedProducts?.title) != nil) {
                headerViewHeightContraints.constant = 48
                
                headerTitleLabel.text = settings.recommendedProducts?.title
                
                if settings.recommendedProducts?.displayTitle ?? false {
                    headerTitleLabel.isHidden = false
                } else {
                    headerTitleLabel.isHidden = true
                }
                
                if settings.recommendedProducts?.displaySeeMore ?? false {
                    headerSeeMoreButton.isHidden = false
                } else {
                    headerSeeMoreButton.isHidden = true
                }
                
            } else {
                headerView.isHidden = true
                headerViewHeightContraints.constant = 0
            }
        }
    }
    
    private func bindData() {
        if let productModel = productModel {
            if !(productModel.relatedProducts?.isEmpty ?? false) {
                setupCellHeight(productModel)
            }
        }
    }
    
    private func setupCellHeight (_ productModel: ProductModel) {
        if productModel.relatedProducts?.count ?? 0 > 2 {
            collectionViewHeightConstrains.constant = 530
        } else {
            collectionViewHeightConstrains.constant = 265
        }
    }
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid2CollectionViewCell.identifier)
    }
    
    @IBAction func seeAlButtonClicked(_ sender: UIButton) {
        delegate?.seeAllButtonClicked()
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension RecommendedProductsType3TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = productModel, !(model.relatedProducts?.isEmpty ?? false) {
            return model.relatedProducts?.count ?? 0
        }
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid2CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
            
            if let model = productModel, !(model.relatedProducts?.isEmpty ?? false) {
                cell.productModel = model.relatedProducts?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 32) / 2
        
        return CGSize(width: cellWidth, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = productModel, !(model.relatedProducts?.isEmpty ?? false) {
            if let products = model.relatedProducts {
                delegate?.productClicked(products[indexPath.row])
            }
        }
    }
}
