//
//  CategoryDetailsProductsView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/10/2023.
//

import UIKit

class CategoryDetailsProductsView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isLoadingShimmer = true
    var productListDesign: String?
    
    var products: [ProductModel] = [] {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.collectionView.reloadData()
                self.stopShimmerOn(collectionView: self.collectionView)
            }
        }
    }
    
    func initialize() {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.categoryDetails.rawValue})?.settings {
            productListDesign = settings.productsList?.design
        }
        setupView()
        startShimmerOn(collectionView: collectionView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.collectionView.reloadData()
        }
    }
    
    private func setupView() {
        registerCollectionViewCells()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
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
            UINib(nibName: ShimmerProductVerticalGrid2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerProductVerticalGrid2CollectionViewCell.identifier)
    }
    
    func startShimmerOn(collectionView: UICollectionView) {
        isLoadingShimmer = true
        DispatchQueue.main.async {
            collectionView.windless.apply {
                $0.animationBackgroundColor = .windlessAnimationBackgroundColor
                $0.animationLayerColor = .windlessAnimationLayerColor
                $0.duration = 1.5
                $0.pauseDuration = 1
                $0.direction = .rightDiagonal
            }.start()
        }
    }
    
    func stopShimmerOn(collectionView: UICollectionView) {
        isLoadingShimmer = false
        collectionView.windless.end()
    }
}

// MARK: - CollectionView Delegate && DataSource
extension CategoryDetailsProductsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.products.isEmpty {
            return 10
        }
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoadingShimmer || self.products.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShimmerProductVerticalGrid2CollectionViewCell.identifier,
                for: indexPath) as? ShimmerProductVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        }
        
        switch productListDesign {
        case ProductListDesign.grid1.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid1CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid1CollectionViewCell else { return UICollectionViewCell() }
            
            cell.productModel = self.products[indexPath.row]
            
            return cell
        case ProductListDesign.grid2.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid2CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid2CollectionViewCell else { return UICollectionViewCell() }
            
            cell.productModel = self.products[indexPath.row]
            
            return cell
        case ProductListDesign.grid3.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid3CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid3CollectionViewCell else { return UICollectionViewCell() }
            
            cell.productModel = self.products[indexPath.row]
            
            return cell
        case ProductListDesign.grid4.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid4CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid4CollectionViewCell else { return UICollectionViewCell() }
            
            cell.productModel = self.products[indexPath.row]
            
            return cell
        case ProductListDesign.grid5.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid5CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid5CollectionViewCell else { return UICollectionViewCell() }
            
            cell.productModel = self.products[indexPath.row]
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2 //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        switch productListDesign {
        case ProductListDesign.grid1.rawValue,
            ProductListDesign.grid5.rawValue:
            return CGSize(width: size, height: 200)
        case ProductListDesign.grid2.rawValue:
            return CGSize(width: size, height: 260)
        case ProductListDesign.grid3.rawValue:
            return CGSize(width: size, height: 250)
        case ProductListDesign.grid4.rawValue:
            return CGSize(width: size, height: 155)
        default:
            return CGSize(width: size, height: 260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
