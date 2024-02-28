//
//  CurrentOrderTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import UIKit

class CurrentOrderTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var upperSeparatorView: UIView!
    @IBOutlet private weak var bottomSeparatorView: UIView!
    @IBOutlet private weak var orderDataContainerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var orderStatusView: OrderStatusView!

    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var viewDetailsLabel: UILabel!
    @IBOutlet private weak var orderNumberLabel: UILabel!
    @IBOutlet private weak var orderDateLabel: UILabel!
    
    var orderModel: OrderModel? {
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
        
        viewDetailsLabel.text = L10n.Orders.viewDetails
        
        priceLabel.font = .appFont(ofSize: 12, weight: .medium)
        viewDetailsLabel.font = .appFont(ofSize: 12, weight: .semiBold)
        
        orderNumberLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        orderDateLabel.font = .appFont(ofSize: 12, weight: .regular)
        
        orderNumberLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        orderDateLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
        
        priceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        viewDetailsLabel.textColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "")

//        orderDataContainerView.backgroundColor = ThemeManager.colorPalette?.titleSubtitleBgColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleSubtitleBgColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        upperSeparatorView.backgroundColor = UIColor.orderSeparatorColor
        //ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        bottomSeparatorView.backgroundColor = UIColor.orderSeparatorColor
        //ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
    }
    
    private func bindData() {
        if let model = orderModel {
            self.priceLabel.text = model.formattedTotal?.formatted
            orderNumberLabel.text = L10n.Orders.order + (model.uuid ?? "")
            
            if let createdDate = model.createdAt {
                let orderDate = createdDate.components(separatedBy: ".").first ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone.current
                dateFormatter.locale = Locale.current
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // "2023-11-30T19:49:50.000000Z"
                
                if let date = dateFormatter.date(from: orderDate) {
                    let dateStringFormatter = DateFormatter()
                    dateStringFormatter.dateFormat = "MMM dd, yyyy"
                    let dateString = dateStringFormatter.string(from: date)
                    orderDateLabel.text = L10n.Orders.placedOn + dateString
                }
            }
            
            orderStatusView.orderModel = model
        }
    }

    private func registerCollectionViewCells() {
        self.collectionView.register(
            UINib(nibName: OrderCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
    }
    
}

// MARK: - CollectionView Delegate && DataSource
extension CurrentOrderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderModel?.products?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OrderCollectionViewCell.identifier,
                for: indexPath) as? OrderCollectionViewCell else { return UICollectionViewCell() }
            
            cell.productModel = orderModel?.products?[indexPath.row]
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 240, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}
