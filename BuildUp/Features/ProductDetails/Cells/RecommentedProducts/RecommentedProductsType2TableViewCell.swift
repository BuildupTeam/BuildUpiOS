//
//  RecommentedProductsType2TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import UIKit

class RecommentedProductsType2TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headerTitleLabel: UILabel!
    @IBOutlet private weak var headerSeeMoreButton: UIButton!

    var productModel: ProductModel? {
        didSet {
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
        
        headerTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        headerTitleLabel.font = .appFont(ofSize: 17, weight: .semiBold)
        headerSeeMoreButton.titleLabel?.font = .appFont(ofSize: 13, weight: .semiBold)
        headerSeeMoreButton.setTitleColor(ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? ""), for: .normal)
        
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
            headerTitleLabel.text = settings.recommendedProducts?.title
            
            if settings.recommendedProducts?.displayTitle ?? false {
                headerView.isHidden = false
            } else {
                headerView.isHidden = false
            }
            
            if settings.recommendedProducts?.displaySeeMore ?? false {
                headerSeeMoreButton.isHidden = false
            } else {
                headerSeeMoreButton.isHidden = true
            }
        }
    }
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: RecommentedProductsType2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: RecommentedProductsType2CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension RecommentedProductsType2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                withReuseIdentifier: RecommentedProductsType2CollectionViewCell.identifier,
                for: indexPath) as? RecommentedProductsType2CollectionViewCell else { return UICollectionViewCell() }
            
            if let model = productModel, !(model.relatedProducts?.isEmpty ?? false) {
                cell.productModel = model.relatedProducts?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 182, height: 266)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        delegate?.homeCityTapped(cityModel: cities[indexPath.row])
    }
}
