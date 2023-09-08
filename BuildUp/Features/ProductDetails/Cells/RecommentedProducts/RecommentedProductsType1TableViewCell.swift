//
//  RecommentedProductsType1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import UIKit

class RecommentedProductsType1TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var recomendedProducts: [ProductModel]?
    
    var productModel: ProductModel? {
        didSet {
            self.collectionView.reloadData()
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
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: RecommentedProductsType1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: RecommentedProductsType1CollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension RecommentedProductsType1TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = productModel, !(model.relatedProducts?.isEmpty ?? false) {
            return model.relatedProducts?.count ?? 0
        }
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommentedProductsType1CollectionViewCell.identifier,
                for: indexPath) as? RecommentedProductsType1CollectionViewCell else { return UICollectionViewCell() }
            
            if let model = productModel, !(model.relatedProducts?.isEmpty ?? false) {
                cell.productModel = model.relatedProducts?[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        delegate?.homeCityTapped(cityModel: cities[indexPath.row])
    }
}
