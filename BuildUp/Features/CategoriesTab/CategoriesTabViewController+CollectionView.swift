//
//  CategoriesTabViewController+CollectionView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/11/2023.
//

import Foundation
import UIKit

extension CategoriesTabViewController {
    func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid1CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid2CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid3CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid3CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid4CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid4CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid5CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid5CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerProductVerticalGridCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerProductVerticalGridCollectionViewCell.identifier)
    }
    
    func setupCollectionViewLayout() {
        let cellWidth = (UIScreen.main.bounds.width - 86) / 2
        var cellheight = CGFloat(210)
        
        if let settings = viewModel.categoryListSettings {
            switch settings.categoriesTabDesign {
            case ProductListDesign.grid1.rawValue,
                ProductListDesign.grid5.rawValue:
                cellheight = 210
            case ProductListDesign.grid2.rawValue:
                cellheight = 260
            case ProductListDesign.grid3.rawValue:
                cellheight = 255
            case ProductListDesign.grid4.rawValue:
                cellheight = 155
            default:
                cellheight = 0
            }
        }
        let cellSize = CGSize(width: cellWidth,
                              height: cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Delegate && DataSource
extension CategoriesTabViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoadingShimmer {
            return 20
        }
        return self.viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoadingShimmer {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShimmerProductVerticalGridCollectionViewCell.identifier,
                for: indexPath) as? ShimmerProductVerticalGridCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        }
        
        if let settings = viewModel.categoryListSettings {
            switch settings.categoriesTabDesign {
            case ProductListDesign.grid1.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProductVerticalGrid1CollectionViewCell.identifier,
                    for: indexPath) as? ProductVerticalGrid1CollectionViewCell else { return UICollectionViewCell() }
                
                cell.productModel = viewModel.products[indexPath.row]
                
                return cell
            case ProductListDesign.grid2.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProductVerticalGrid2CollectionViewCell.identifier,
                    for: indexPath) as? ProductVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
                
                cell.productModel = viewModel.products[indexPath.row]
                
                return cell
            case ProductListDesign.grid3.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProductVerticalGrid3CollectionViewCell.identifier,
                    for: indexPath) as? ProductVerticalGrid3CollectionViewCell else { return UICollectionViewCell() }
                
                cell.productModel = viewModel.products[indexPath.row]
                
                return cell
            case ProductListDesign.grid4.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProductVerticalGrid4CollectionViewCell.identifier,
                    for: indexPath) as? ProductVerticalGrid4CollectionViewCell else { return UICollectionViewCell() }
                
                cell.productModel = viewModel.products[indexPath.row]
                
                return cell
            case ProductListDesign.grid5.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProductVerticalGrid5CollectionViewCell.identifier,
                    for: indexPath) as? ProductVerticalGrid5CollectionViewCell else { return UICollectionViewCell() }
                
                cell.productModel = viewModel.products[indexPath.row]
                
                return cell
            default:
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.products.count - 1) &&
            (viewModel.products.count >= viewModel.perPage) {
            if !isReloadingTableView {
                if viewModel.responseModel?.pagination?.cursorMeta?.nextCursor != nil {
                    self.loadMoreProducts()
//                    addSpinnerToTableView()
                }
            } else {
                isReloadingTableView = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.products.isEmpty {
            return
        }
        let productModel = viewModel.products[indexPath.row]
        let detailsVC = Coordinator.Controllers.createProductDetailsViewController()
        detailsVC.productModel = productModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
