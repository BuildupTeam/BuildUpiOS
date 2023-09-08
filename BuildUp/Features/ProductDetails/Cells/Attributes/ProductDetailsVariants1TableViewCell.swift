//
//  ProductDetailsAttributeType1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 31/08/2023.
//

import UIKit

class ProductDetailsVariants1TableViewCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seperatorView: UIView!

    var optionModel: ProductDetailsOptionsModel? {
        didSet {
            self.bindData()
            self.collectionView.reloadData()
        }
    }
    var productModel: ProductModel? {
        didSet {
            self.bindData()
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        titleLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
        
        registerCollectionViewCells()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bindData() {
        titleLabel.text = optionModel?.option?.name
    }
    
    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: ProductDetailsVariants1CollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ProductDetailsVariants1CollectionViewCell.identifier)
    }
}

// MARK: - CollectionView Delegate && DataSource
extension ProductDetailsVariants1TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let options = optionModel?.optionValues, !options.isEmpty {
            return options.count
        }
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductDetailsVariants1CollectionViewCell.identifier,
                for: indexPath) as? ProductDetailsVariants1CollectionViewCell else { return UICollectionViewCell() }
            
            if let options = optionModel?.optionValues, !options.isEmpty {
                cell.optionValueModel = options[indexPath.row]
            }
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let options = optionModel?.optionValues, !options.isEmpty {
            let optionValueModel = options[indexPath.row]
            let textWidth = optionValueModel.name?.width(withConstrainedHeight: 32, font: .appFont(ofSize: 12, weight: .semiBold)) ?? 0
            return CGSize(width: textWidth + 32, height: 70)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        delegate?.homeCityTapped(cityModel: cities[indexPath.row])
    }
}
