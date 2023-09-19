//
//  CategoriesListViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import Foundation
import UIKit

enum CategoriesListDesign: String {
    case categoriesGrid1 = "product-vertical-grid-1"
    case categoriesGrid2 = "product-vertical-grid-2"
    case categoriesGrid3 = "product-vertical-grid-3"
}

// MARK: Register TableView Cells
extension CategoriesListViewController {
    func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: CategoriesVerticalGrid1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoriesVerticalGrid1CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: CategoriesVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoriesVerticalGrid2CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: CategoriesVerticalGrid3CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoriesVerticalGrid3CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerCategoriesVerticalGrid1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerCategoriesVerticalGrid1CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: ShimmerCategoriesVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerCategoriesVerticalGrid2CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: ShimmerCategoriesVerticalGrid3CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerCategoriesVerticalGrid3CollectionViewCell.identifier)
    }
}

// MARK: - CollectionView Delegate && DataSource
extension CategoriesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.categories.isEmpty {
            return 10
        }
        return self.viewModel.categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if isLoadingShimmer {
                if let settings = viewModel.categoryListSettings {
                    switch settings.list {
                    case CategoriesListDesign.categoriesGrid1.rawValue:
                        guard let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: ShimmerCategoriesVerticalGrid1CollectionViewCell.identifier,
                            for: indexPath) as? ShimmerCategoriesVerticalGrid1CollectionViewCell else { return UICollectionViewCell() }
                        
                        return cell
                    case CategoriesListDesign.categoriesGrid2.rawValue:
                        guard let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: ShimmerCategoriesVerticalGrid2CollectionViewCell.identifier,
                            for: indexPath) as? ShimmerCategoriesVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
                        
                        return cell
                    case CategoriesListDesign.categoriesGrid3.rawValue:
                        guard let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: ShimmerCategoriesVerticalGrid3CollectionViewCell.identifier,
                            for: indexPath) as? ShimmerCategoriesVerticalGrid3CollectionViewCell else { return UICollectionViewCell() }
                        
                        return cell
                    default:
                        return UICollectionViewCell()
                    }
                }
            }
            
            if let settings = viewModel.categoryListSettings {
                switch settings.list {
                case CategoriesListDesign.categoriesGrid1.rawValue:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CategoriesVerticalGrid1CollectionViewCell.identifier,
                        for: indexPath) as? CategoriesVerticalGrid1CollectionViewCell else { return UICollectionViewCell() }
                    
                    cell.categoryModel = viewModel.categories[indexPath.row]
                    
                    return cell
                case CategoriesListDesign.categoriesGrid2.rawValue:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CategoriesVerticalGrid2CollectionViewCell.identifier,
                        for: indexPath) as? CategoriesVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
                    
                    cell.categoryModel = viewModel.categories[indexPath.row]
                    
                    return cell
                case CategoriesListDesign.categoriesGrid3.rawValue:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CategoriesVerticalGrid3CollectionViewCell.identifier,
                        for: indexPath) as? CategoriesVerticalGrid3CollectionViewCell else { return UICollectionViewCell() }
                    
                    cell.categoryModel = viewModel.categories[indexPath.row]
                    
                    return cell
                default:
                    return UICollectionViewCell()
                }
            }
            return UICollectionViewCell()
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth = UIScreen.main.bounds.width
//        let cellWidth = (screenWidth - 32) / 2
//
//        return CGSize(width: cellWidth, height: 260)
        
        let noOfCellsInRow = 2   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        if let settings = viewModel.categoryListSettings {
            switch settings.list {
            case CategoriesListDesign.categoriesGrid1.rawValue:
                return CGSize(width: size, height: 128)
            case CategoriesListDesign.categoriesGrid2.rawValue:
                return CGSize(width: size, height: 180)
            case CategoriesListDesign.categoriesGrid3.rawValue:
                return CGSize(width: size, height: 130)
            default:
                return CGSize.zero
            }
        }
        return CGSize(width: size, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
