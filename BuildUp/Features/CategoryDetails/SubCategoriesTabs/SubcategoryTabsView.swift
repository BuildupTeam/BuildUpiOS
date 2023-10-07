//
//  SubcategoryTabsView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 17/09/2023.
//

import UIKit

enum SubcategoryTabsDesign: String {
    case horizontal = "categories-horizontal-list-1"
//    case horizonta2 = "categories-horizontal-list-2"
}

protocol subcategoryTabsViewDelegate: AnyObject {
    func subcategoryClicked(_ model: CategoryModel)
}

class SubcategoryTabsView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var isLoadingShimmer = true
    weak var delegate: subcategoryTabsViewDelegate?
 
    var subCategories: [CategoryModel]? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.collectionView.reloadData()
                self.stopShimmerOn(collectionView: self.collectionView)
            }
        }
    }
    
    func initialize() {
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
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: CategoriesHorizontalList1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoriesHorizontalList1CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: CategoriesHorizontalList2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoriesHorizontalList2CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerCategoriesHorizontal1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerCategoriesHorizontal1CollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: ShimmerCategoriesHorizontal2CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerCategoriesHorizontal2CollectionViewCell.identifier)
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

extension SubcategoryTabsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategories?.count ?? 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if isLoadingShimmer == true {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShimmerCategoriesHorizontal1CollectionViewCell.identifier,
                    for: indexPath) as? ShimmerCategoriesHorizontal1CollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoriesHorizontalList1CollectionViewCell.identifier,
                for: indexPath) as? CategoriesHorizontalList1CollectionViewCell else { return UICollectionViewCell() }
            
            cell.categoryModel = subCategories?[indexPath.row]
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isLoadingShimmer == true {
            return CGSize(width: 80, height: 40)
        }
        if let model = subCategories?[indexPath.row] {
            let textWidth = model.name?.width(withConstrainedHeight: 40, font: .appFont(ofSize: 15, weight: .regular)) ?? 0
            return CGSize(width: (textWidth + 32), height: 40)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if var subCategories = subCategories {
            for model in subCategories {
                model.isSelected = false
            }
            var model = subCategories[indexPath.row]
            model.isSelected = true
            subCategories[indexPath.row] = model
            self.collectionView.reloadData()
            delegate?.subcategoryClicked(model)
        }
        
    }
}
