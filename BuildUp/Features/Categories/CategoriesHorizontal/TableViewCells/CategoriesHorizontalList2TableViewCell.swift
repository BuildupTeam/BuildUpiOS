//
//  CategoriesWithSelectedTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesHorizontalList2TableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!

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
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension CategoriesHorizontalList2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoriesHorizontalList2CollectionViewCell.identifier,
                for: indexPath) as? CategoriesHorizontalList2CollectionViewCell else { return UICollectionViewCell() }
            
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textWidth = "mohamed".width(withConstrainedHeight: 40, font: .appFont(ofSize: 15, weight: .regular)) ?? 0
        
        return CGSize(width: (textWidth + 32), height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        delegate?.homeCityTapped(cityModel: cities[indexPath.row])
    }
}
