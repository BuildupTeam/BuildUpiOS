//
//  ProductVerticalGrid4TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/06/2023.
//

import UIKit

class ProductVerticalGrid4TableViewCell: UITableViewCell {

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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
        registerCollectionViewCells()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func bindData() {
        if let homeSection = homeSectionModel {
            if !(homeSection.products?.isEmpty ?? false) {
                if homeSection.products?.count ?? 0 > 3 {
                    collectionViewHeightConstrains.constant = 320
                } else {
                    collectionViewHeightConstrains.constant = 155
                }
            }
        }
    }
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductVerticalGrid4CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductVerticalGrid4CollectionViewCell.identifier)
        
        self.collectionView.register(
            UINib(nibName: ShimmerProductVerticalGrid4CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ShimmerProductVerticalGrid4CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension ProductVerticalGrid4TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                    withReuseIdentifier: ShimmerProductVerticalGrid4CollectionViewCell.identifier,
                    for: indexPath) as? ShimmerProductVerticalGrid4CollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductVerticalGrid4CollectionViewCell.identifier,
                for: indexPath) as? ProductVerticalGrid4CollectionViewCell else { return UICollectionViewCell() }
            
            if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
                cell.productModel = sectionModel.products?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let screenWidth = UIScreen.main.bounds.width
        //        let cellWidth = (screenWidth - 16) / 3
        //
        //        return CGSize(width: cellWidth, height: 155)
        
        let noOfCellsInRow = 3   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
            delegate?.homeProductTapped(productModel: sectionModel.products?[indexPath.row])
        }
    }
}

