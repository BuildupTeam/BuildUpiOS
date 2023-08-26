//
//  ProductVerticalList1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/06/2023.
//

import UIKit

class ProductVerticalList1TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var tableView: UITableView!
    var isLoadingShimmer: Bool?

    var homeSectionModel: HomeSectionModel? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        self.tableView.register(
            UINib(nibName: ProductVerticalList1InnerTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalList1InnerTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerProductVerticalListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerProductVerticalListTableViewCell.identifier)
    }
}

extension ProductVerticalList1TableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
            return sectionModel.products?.count ?? 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let isLoadingShimmer = isLoadingShimmer, isLoadingShimmer == true {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ShimmerProductVerticalListTableViewCell.identifier,
                for: indexPath) as? ShimmerProductVerticalListTableViewCell
            else { return UITableViewCell() }
            
            
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalList1InnerTableViewCell.identifier,
            for: indexPath) as? ProductVerticalList1InnerTableViewCell
        else { return UITableViewCell() }
        
        if let sectionModel = homeSectionModel, !(sectionModel.products?.isEmpty ?? false) {
            cell.productModel = sectionModel.products?[indexPath.row]
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
