//
//  ProductDetailsAttributeType3TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 31/08/2023.
//

import UIKit

class ProductDetailsVariants3TableViewCell: UITableViewCell {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var seperatorView: UIView!

    var optionModel: ProductDetailsOptionsModel? {
        didSet {
            self.bindData()
            self.tableView.reloadData()
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
        registerTableViewCell()
        tableView.delegate = self
        tableView.dataSource = self
        
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
    }
    
    private func registerTableViewCell() {
        self.tableView.register(
            UINib(nibName: ProductDetailsVariants3InnerTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductDetailsVariants3InnerTableViewCell.identifier)
    }
    
    private func bindData() {
        
    }
}

extension ProductDetailsVariants3TableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let options = optionModel?.optionValues, !options.isEmpty {
            return options.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductDetailsVariants3InnerTableViewCell.identifier,
            for: indexPath) as? ProductDetailsVariants3InnerTableViewCell
        else { return UITableViewCell() }
        
        cell.optionModel = self.optionModel
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
