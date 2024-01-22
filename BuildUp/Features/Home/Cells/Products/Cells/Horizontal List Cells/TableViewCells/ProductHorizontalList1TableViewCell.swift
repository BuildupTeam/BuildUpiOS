//
//  ProductHorizontalList1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/06/2023.
//

import UIKit

class ProductHorizontalList1TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstrains: NSLayoutConstraint!

    var isLoadingShimmer: Bool?
    weak var delegate: HomeProductsCellDelegate?
    weak var addToFavDelegate: ProductFavoriteDelegate?

    var homeSectionModel: HomeSectionModel? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.collectionView.reloadData()
            }
            
            bindData()
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
        
    }
    
    private func bindData() {
        
    }

    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductHorizontalList1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductHorizontalList1CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: ShimmerProductHorizontalList1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerProductHorizontalList1CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension ProductHorizontalList1TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
            return sectionModel.products?.count ?? 0
        }
        return 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if let isLoadingShimmer = isLoadingShimmer, isLoadingShimmer == true {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShimmerProductHorizontalList1CollectionViewCell.identifier,
                    for: indexPath) as? ShimmerProductHorizontalList1CollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductHorizontalList1CollectionViewCell.identifier,
                for: indexPath) as? ProductHorizontalList1CollectionViewCell else { return UICollectionViewCell() }
            
            if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
                cell.productModel = sectionModel.products?[indexPath.row]
            }
            
            cell.addToFavDelegate = self
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
            delegate?.homeProductTapped(productModel: sectionModel.products?[indexPath.row], componentModel: sectionModel.component)
        }
    }
}

extension ProductHorizontalList1TableViewCell: ProductFavoriteDelegate {
    func pleaseLoginFirst() {
        addToFavDelegate?.pleaseLoginFirst()
    }
    
    func productFavorite(model: ProductModel) {
        
    }
}
