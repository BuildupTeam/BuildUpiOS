//
//  ProductVerticalGrid3TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalGrid3TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstrains: NSLayoutConstraint!

    weak var delegate: HomeProductsCellDelegate?

    var isLoadingShimmer: Bool?

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
        if let homeSection = homeSectionModel {
            if !(homeSection.products?.isEmpty ?? false) {
                if homeSection.products?.count ?? 0 > 2 {
                    collectionViewHeightConstrains.constant = 506
                } else {
                    collectionViewHeightConstrains.constant = 253
                }
            }
        }
    }

    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid3CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid3CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerProductVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerProductVerticalGrid2CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension ProductVerticalGrid3TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                    withReuseIdentifier: ShimmerProductVerticalGrid2CollectionViewCell.identifier,
                    for: indexPath) as? ShimmerProductVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid3CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid3CollectionViewCell else { return UICollectionViewCell() }
            
            if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
                cell.productModel = sectionModel.products?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 32) / 2
        
        return CGSize(width: cellWidth, height: 516)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
            delegate?.homeProductTapped(productModel: sectionModel.products?[indexPath.row])
        }
    }
}
