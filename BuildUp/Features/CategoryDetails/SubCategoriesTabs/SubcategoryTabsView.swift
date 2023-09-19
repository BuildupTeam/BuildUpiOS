//
//  SubcategoryTabsView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 17/09/2023.
//

import UIKit

enum SubcategoryTabsDesign: String {
    case horizontal = "categories-horizontal-list-1"
    case horizonta2 = "categories-horizontal-list-2"
}

class SubcategoryTabsView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var isLoadingShimmer = true

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
            if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.categoryDetails.rawValue})?.settings {
                switch settings.subcategoryTabs?.design {
                case SubcategoryTabsDesign.horizontal.rawValue:
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
                case SubcategoryTabsDesign.horizonta2.rawValue:
                    if isLoadingShimmer == true {
                        guard let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: ShimmerCategoriesHorizontal2CollectionViewCell.identifier,
                            for: indexPath) as? ShimmerCategoriesHorizontal2CollectionViewCell else { return UICollectionViewCell() }
                        
                        return cell
                    }
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CategoriesHorizontalList2CollectionViewCell.identifier,
                        for: indexPath) as? CategoriesHorizontalList2CollectionViewCell else { return UICollectionViewCell() }
                    
                    cell.categoryModel = subCategories?[indexPath.row]
                    
                    return cell
                default:
                    return UICollectionViewCell()
                }
            }
            return UICollectionViewCell()
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.categoryDetails.rawValue})?.settings {
            switch settings.subcategoryTabs?.design {
            case SubcategoryTabsDesign.horizontal.rawValue:
                if isLoadingShimmer == true {
                    return CGSize(width: 80, height: 40)
                }
                if let model = subCategories?[indexPath.row] {
                    let textWidth = model.name?.width(withConstrainedHeight: 40, font: .appFont(ofSize: 15, weight: .regular)) ?? 0
                    return CGSize(width: (textWidth + 32), height: 40)
                }
            case SubcategoryTabsDesign.horizonta2.rawValue:
                if isLoadingShimmer == true {
                    return CGSize(width: 80, height: 110)
                }
                return CGSize(width: 88, height: 110)
            default:
                return CGSize.zero
            }
        }
        
        return CGSize.zero
    }
}
