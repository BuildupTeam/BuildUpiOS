//
//  RecommentedProductsType2TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import UIKit

class RecommentedProductsType2TableViewCell: UITableViewCell {

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
        
        headerTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        headerTitleLabel.font = .appFont(ofSize: 17, weight: .semiBold)
        headerSeeMoreButton.titleLabel?.font = .appFont(ofSize: 13, weight: .semiBold)
        headerSeeMoreButton.setTitleColor(ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? ""), for: .normal)
        headerSeeMoreButton.tintColor = ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? "")
        
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
            if ((settings.recommendedProducts?.title) != nil) {
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
                
//                if (settings.recommendedProducts?.displayTitle ?? false) && ( settings.recommendedProducts?.displaySeeMore ?? false) {
//                    headerView.isHidden = false
//                } else {
//                    headerView.isHidden = true
//                }
            } else {
                headerView.isHidden = true
//                containerViewHeightContraints.constant = 232
//                headerViewHeightContraints.constant = 0
            }
        }
    }
    
    private func bindData() {
        
        if let productModel = productModel {
            if !(productModel.relatedProducts?.isEmpty ?? false) {
                if productModel.relatedProducts?.count ?? 0 > 2 {
                    collectionViewHeightConstrains.constant = 400
//                    if containerViewHeightContraints.constant == 272 {
//                        containerViewHeightContraints.constant = 472
//                    } else if containerViewHeightContraints.constant == 232 {
//                        collectionViewHeightConstrains.constant = 432
//                    }
                } else {
                    collectionViewHeightConstrains.constant = 200
                }
            }
        }
    }
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid1CollectionViewCell.identifier)
    }
    
    @IBAction func seeAlButtonClicked(_ sender: UIButton) {
        delegate?.seeAllButtonClicked()
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
                withReuseIdentifier: ProductVerticalGrid1CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid1CollectionViewCell else { return UICollectionViewCell() }
            
            if let model = productModel, !(model.relatedProducts?.isEmpty ?? false) {
                cell.productModel = model.relatedProducts?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 32) / 2
        
        return CGSize(width: cellWidth, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = productModel, !(model.relatedProducts?.isEmpty ?? false) {
            if let products = model.relatedProducts {
                delegate?.productClicked(products[indexPath.row])
            }
        }
    }
}
