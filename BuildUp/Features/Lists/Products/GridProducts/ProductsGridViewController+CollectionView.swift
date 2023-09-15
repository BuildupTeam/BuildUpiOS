//
//  ProductstGridViewController+CollectionView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import Foundation
import UIKit

// MARK: Register TableView Cells
extension ProductsGridViewController {
    func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid2CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerProductVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerProductVerticalGrid2CollectionViewCell.identifier)
    }
}

// MARK: - CollectionView Delegate && DataSource
extension ProductsGridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.products.isEmpty {
            return 10
        }
        return self.viewModel.products.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if isLoadingShimmer {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShimmerProductVerticalGrid2CollectionViewCell.identifier,
                    for: indexPath) as? ShimmerProductVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid2CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
            
            cell.productModel = viewModel.products[indexPath.row]
            
            return cell
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
        return CGSize(width: size, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
