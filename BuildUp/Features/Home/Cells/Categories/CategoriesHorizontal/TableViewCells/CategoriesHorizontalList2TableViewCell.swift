//
//  CategoriesWithSelectedTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesHorizontalList2TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    var isLoadingShimmer: Bool?
    weak var delegate: HomeCategoriesCellDelegate?

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
            UINib(nibName: CategoriesHorizontalList2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoriesHorizontalList2CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerCategoriesHorizontal2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerCategoriesHorizontal2CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension CategoriesHorizontalList2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionModel = homeSectionModel, !(sectionModel.categories?.isEmpty ?? false) {
            return sectionModel.categories?.count ?? 0
        }
        return 6
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if let isLoadingShimmer = isLoadingShimmer, isLoadingShimmer == true {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShimmerCategoriesHorizontal2CollectionViewCell.identifier,
                    for: indexPath) as? ShimmerCategoriesHorizontal2CollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoriesHorizontalList2CollectionViewCell.identifier,
                for: indexPath) as? CategoriesHorizontalList2CollectionViewCell else { return UICollectionViewCell() }
            
            if let sectionModel = homeSectionModel, !(sectionModel.categories?.isEmpty ?? false) {
                cell.categoryModel = sectionModel.categories?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let sectionModel = homeSectionModel, !(sectionModel.categories?.isEmpty ?? false) {
            let model = sectionModel.categories?[indexPath.row]
            let textWidth = model?.name?.width(withConstrainedHeight: 88, font: .appFont(ofSize: 15, weight: .regular)) ?? 0
            if (textWidth + 32) < 88 {
                return CGSize(width: 90, height: 125)
            }
            return CGSize(width: (textWidth + 32), height: 125)
        }
        
        return CGSize(width: 90, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sectionModel = homeSectionModel, !(sectionModel.categories?.isEmpty ?? false) {
            delegate?.homeCategoryTapped(categoryModel: sectionModel.categories?[indexPath.row], componentModel: sectionModel.component)
        }
    }
}
