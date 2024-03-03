//
//  CitiesViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit

protocol CitiesDelegate: AnyObject {
    func citySelected(cityModel: CityModel)
}

class CitiesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    weak var delegate: CitiesDelegate?
    
    var isReloadingTableView = false
    var viewModel: CitiesViewModel!
        
    init(viewModel: CitiesViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        citiesResponse()
        getCities()
        startShimmerOn(tableView: tableView)
    }

    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        
        titleLabel.text = L10n.Checkout.cities
        titleLabel.font = .appFont(ofSize: 16, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: CityTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CityTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerCityTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerCityTableViewCell.identifier)
    }
    
    private func getCities() {
        if let countryId = CachingService.getThemeData()?.appCountryId?.id {
            self.viewModel.getCities(countryId: countryId)
        }
    }
    
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.tableView.reloadData()
    }
    
    private func citiesResponse() {
        self.viewModel.onCities = { [weak self]() in
            guard let `self` = self else { return }
            if self.viewModel.cities?.isEmpty ?? false {
                self.setupEmptyView()
            } else {
                self.removeBackgroundViews()
            }
            self.stopShimmerOn(tableView: self.tableView)
            self.tableView.reloadData()
        }
    }
    
    private func setupEmptyView() {
        removeBackgroundViews()
        let emptyNib = EmptyScreenView.instantiateFromNib()
        emptyNib.frame = tableView.backgroundView?.frame ?? CGRect()
        emptyNib.title = L10n.EmptyScreen.noData
        emptyNib.emptyImage = Asset.icNoOrders.image
//        emptyNib.emptyImage = Asset.icEmptyViewSearch.image
        emptyNib.showButton = false
        tableView.backgroundView = emptyNib
    }
    
    private func removeBackgroundViews() {
        tableView.backgroundView = nil
    }
}

// MARK: - TableView Delegate && DataSource
extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoadingShimmer {
            return 10
        }
        return self.viewModel.cities?.count ?? 0
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
                withIdentifier: CityTableViewCell.identifier,
                for: indexPath) as? CityTableViewCell
            else { return UITableViewCell() }
            
            if let cityModel = self.viewModel.cities?[indexPath.row] {
                cell.cityModel = cityModel
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = self.viewModel.cities?[indexPath.row] {
            delegate?.citySelected(cityModel: city)
            self.dismiss(animated: true)
        }
    }
}
