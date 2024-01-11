//
//  OrderDetailsProductsTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import UIKit

class OrderDetailsProductsTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var itemsCountTitleLabel: UILabel!
    @IBOutlet private weak var itemsCountLabel: UILabel!

    var products: [ProductModel]? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.collectionView.reloadData()
            }
            self.bindData()
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
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        itemsCountTitleLabel.text = L10n.Checkout.items
        
        itemsCountTitleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        itemsCountLabel.font = .appFont(ofSize: 14, weight: .medium)
        
        itemsCountTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        itemsCountLabel.textColor = UIColor.checkoutItemsColor
        
        ThemeManager.setShadow(element: containerView,
                               shadowRadius: CGFloat(11),
                               xOffset: 0, yOffset: 0,
                               color: .black, opacity: 1,
                               cornerRadius: 8,
                               masksToBounds: false)
    }
    
    private func bindData() {
        if let count = products?.count {
            self.itemsCountLabel.text = "(\(String(count)) \(L10n.Checkout.items))"
        }
    }

    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: CheckoutProductCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CheckoutProductCollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension OrderDetailsProductsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CheckoutProductCollectionViewCell.identifier,
                for: indexPath) as? CheckoutProductCollectionViewCell else { return UICollectionViewCell() }
            
            cell.productModel = products?[indexPath.row]
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 240, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}
