//
//  CountriesViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit

protocol CountriesDelegate: AnyObject {
    func countrySelected(countryModel: CountryModel)
}

class CountriesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    weak var delegate: CountriesDelegate?
    
    var isReloadingTableView = false
    var viewModel: CountiresViewModel!
        
    init(viewModel: CountiresViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        countriesResponse()
        getCountries()
        startShimmerOn(tableView: tableView)
    }
    
    private func setupView() {
        isLoadingShimmer = true
        registerTableViewCells()
        
        titleLabel.text = L10n.Checkout.countries
        titleLabel.font = .appFont(ofSize: 16, weight: .semiBold)
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: CountryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CountryTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerCountryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerCountryTableViewCell.identifier)
    }

    private func getCountries() {
        self.viewModel.getCountries()
    }
    
    private func reloadTableViewData() {
        self.isReloadingTableView = true
        self.tableView.reloadData()
    }
    
    private func countriesResponse() {
        self.viewModel.onCountries = { [weak self]() in
            guard let `self` = self else { return }
            if self.viewModel.countries?.isEmpty ?? false {
                self.setupEmptyView()
            } else {
                self.removeBackgroundViews()
            }
            self.tableView.reloadData()
            self.stopShimmerOn(tableView: self.tableView)
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
extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.countries?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingShimmer {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ShimmerCountryTableViewCell.identifier,
                for: indexPath) as? ShimmerCountryTableViewCell
            else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CountryTableViewCell.identifier) as? CountryTableViewCell
            else { return UITableViewCell() }
            
            cell.countryModel = self.viewModel.countries?[indexPath.row]
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let country = self.viewModel.countries?[indexPath.row] {
            delegate?.countrySelected(countryModel: country)
            self.dismiss(animated: true)
        }
    }
    
}
