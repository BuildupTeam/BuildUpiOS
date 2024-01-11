//
//  AreasViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

protocol AreasDelegate: AnyObject {
    func areaSelected(areaModel: AreaModel)
}

class AreasViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    weak var delegate: AreasDelegate?
    
    var isReloadingTableView = false
    var viewModel: AreasViewModel!
    
    init(viewModel: AreasViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        areasResponse()
        getAreas()
        startShimmerOn(tableView: tableView)
    }
    
    private func setupEmptyView() {
        removeBackgroundViews()
        let emptyNib = EmptyScreenView.instantiateFromNib()
        emptyNib.frame = tableView.backgroundView?.frame ?? CGRect()
        emptyNib.title = L10n.EmptyScreen.noData
//        emptyNib.emptyImage = Asset.icEmptyViewSearch.image
        emptyNib.showButton = false
        tableView.backgroundView = emptyNib
    }
    
    private func removeBackgroundViews() {
        tableView.backgroundView = nil
    }

}

// MARK: - Private func
extension AreasViewController {
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        
        titleLabel.text = L10n.Checkout.areas
        titleLabel.font = .appFont(ofSize: 16, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: AreaTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: AreaTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerCityTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerCityTableViewCell.identifier)
    }
    
    private func getAreas() {
        self.viewModel.getAreas(cityId: self.viewModel.cityModel?.id ?? 0)
    }
    
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.tableView.reloadData()
    }
    
    private func areasResponse() {
        self.viewModel.onAreas = { [weak self]() in
            guard let `self` = self else { return }
            if self.viewModel.areas?.isEmpty ?? false {
                self.setupEmptyView()
            } else {
                self.removeBackgroundViews()
            }
            self.tableView.reloadData()
            self.stopShimmerOn(tableView: self.tableView)
        }
    }
}

// MARK: - TableView Delegate && DataSource
extension AreasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.areas?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ShimmerCityTableViewCell.identifier,
                for: indexPath) as? ShimmerCityTableViewCell
            else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AreaTableViewCell.identifier,
                for: indexPath) as? AreaTableViewCell
            else { return UITableViewCell() }
            
            cell.areaModel = self.viewModel.areas?[indexPath.row]
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = self.viewModel.areas?[indexPath.row] {
            delegate?.areaSelected(areaModel: city)
            self.dismiss(animated: true)
        }
    }
}
