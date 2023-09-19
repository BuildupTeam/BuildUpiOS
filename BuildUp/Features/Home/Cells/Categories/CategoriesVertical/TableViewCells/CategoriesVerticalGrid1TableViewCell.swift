//
//  CategoriesVerticalGrid4TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

protocol HomeCategoriesCellDelegate: AnyObject {
    func homeCategoryTapped(categoryModel: CategoryModel?, componentModel: ComponentConfigurationModel?)
}

class CategoriesVerticalGrid1TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstrains: NSLayoutConstraint!

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
            UINib(nibName: CategoriesVerticalGrid1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoriesVerticalGrid1CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerCategoriesVerticalGrid1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerCategoriesVerticalGrid1CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension CategoriesVerticalGrid1TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                    withReuseIdentifier: ShimmerCategoriesVerticalGrid1CollectionViewCell.identifier,
                    for: indexPath) as? ShimmerCategoriesVerticalGrid1CollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoriesVerticalGrid1CollectionViewCell.identifier,
                for: indexPath) as? CategoriesVerticalGrid1CollectionViewCell else { return UICollectionViewCell() }
            
            if let sectionModel = homeSectionModel, !(sectionModel.categories?.isEmpty ?? false) {
                cell.categoryModel = sectionModel.categories?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 32) / 2
        
        return CGSize(width: cellWidth, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sectionModel = homeSectionModel, !(sectionModel.categories?.isEmpty ?? false) {
            delegate?.homeCategoryTapped(categoryModel: sectionModel.categories?[indexPath.row], componentModel: sectionModel.component)
        }
    }
}
