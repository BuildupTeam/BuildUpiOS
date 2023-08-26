//
//  CategoriesVerticalGrid6TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesVerticalGrid2TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!

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
        
    }

    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: CategoriesVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoriesVerticalGrid2CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerCategoriesVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerCategoriesVerticalGrid2CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension CategoriesVerticalGrid2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionModel = homeSectionModel, !(sectionModel.categories?.isEmpty ?? false) {
            return sectionModel.categories?.count ?? 0
        }
        return 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if let isLoadingShimmer = isLoadingShimmer, isLoadingShimmer == true {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShimmerCategoriesVerticalGrid2CollectionViewCell.identifier,
                    for: indexPath) as? ShimmerCategoriesVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoriesVerticalGrid2CollectionViewCell.identifier,
                for: indexPath) as? CategoriesVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
            
            if let sectionModel = homeSectionModel, !(sectionModel.categories?.isEmpty ?? false) {
                cell.categoryModel = sectionModel.categories?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 32) / 2
        
        return CGSize(width: cellWidth, height: 376)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        delegate?.homeCityTapped(cityModel: cities[indexPath.row])
    }
}
