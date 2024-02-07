//
//  AddNewAddressViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import UIKit

class AddNewAddressViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var addAddressButton: UIButton!
    
    var countryModel: CountryModel?
    var cityModel: CityModel?
    var areaModel: AreaModel?
    var detailedAddress: String?
    var addressModel: AddressModel?
    
    var viewModel: AddNewAddressViewModel!
            
    override  var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: AddNewAddressViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addAddressResponse()
        updateAddressResponse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if addressModel != nil {
            self.title = L10n.Checkout.updateAddress
        } else {
            self.title = L10n.Checkout.addNewAddress
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = " "
    }
    
    private func addAddressResponse() {
        self.viewModel.onAddNewAddress = { [weak self]() in
            guard let `self` = self else { return }
            self.hideLoading()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func updateAddressResponse() {
        self.viewModel.addressUpdated = { [weak self]() in
            guard let `self` = self else { return }
            self.hideLoading()
            self.navigationController?.popViewController(animated: true)
        }
    }

}

// MARK: - Actions
extension AddNewAddressViewController {
    @IBAction func addNewAddressAction(_ sender: UIButton) {
        if let model = addressModel {
            if let countryId = CachingService.getThemeData()?.appCountryId, let cityId = cityModel?.id, let areaId = areaModel?.id, let address = detailedAddress {
                self.showLoading()
                self.viewModel.updateAddress(addressId: model.id ?? 0, countryId: Int(countryId) ?? 0, cityId: cityId, areaId: areaId, address: address)
            }
        } else {
            if let countryId = CachingService.getThemeData()?.appCountryId, let cityId = cityModel?.id, let areaId = areaModel?.id, let address = detailedAddress {
                self.showLoading()
                self.viewModel.addNewAddress(countryId: Int(countryId) ?? 0, cityId: cityId, areaId: areaId, address: address)
            }
        }
    }
}

// MARK: - Private Func
extension AddNewAddressViewController {
    private func setupView() {
        updateAddAddressButtonAppearence()
        registerTableViewCells()
        
        if addressModel != nil {
            fillData()
            updateAddAddressButtonAppearence()
            addAddressButton.setTitle(L10n.Checkout.updateAddress, for: .normal)
        } else {
            addAddressButton.setTitle(L10n.Checkout.addNewAddress, for: .normal)
        }
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        addAddressButton.layer.masksToBounds = true
        addAddressButton.layer.cornerRadius = 8
//        continueButton.backgroundColor = .dimmedButtonGray
        addAddressButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        addAddressButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
    }
    
    private func updateAddAddressButtonAppearence() {
        if CachingService.getThemeData()?.appCountryId != nil &&
            cityModel?.id != nil &&
            areaModel?.id != nil &&
            detailedAddress != nil &&
            !(detailedAddress?.isEmpty ?? false) {
            addAddressButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            addAddressButton.isUserInteractionEnabled = true
        } else {
            addAddressButton.backgroundColor = .dimmedButtonGray
            addAddressButton.isUserInteractionEnabled = false
        }
    }
    
    func openCountriesList() {
        let countriesVC = Coordinator.Controllers.createCountiresViewController()
        countriesVC.delegate = self
        self.present(countriesVC, animated: true, completion: nil)
    }
    
    func openCitiesList() {
        if let countryId = CachingService.getThemeData()?.appCountryId {
            let citiesVC = Coordinator.Controllers.createCitiesViewController()
            citiesVC.delegate = self
            self.present(citiesVC, animated: true, completion: nil)
        } else {
            self.showError(message: L10n.Checkout.Errors.selectCountryFirst)
        }
    }
    
    func openAreaList() {
        if let cityModel = cityModel {
            let areasVC = Coordinator.Controllers.createAreasViewController(cityModel: cityModel)
            areasVC.delegate = self
            self.present(areasVC, animated: true, completion: nil)
        } else {
            self.showError(message: L10n.Checkout.Errors.selectCityFirst)
        }
    }
    
    private func fillData() {
        if let model = addressModel {
            self.countryModel = model.country
            self.cityModel = model.city
            self.areaModel = model.area
            self.detailedAddress = model.addressDescription
            self.tableView.reloadData()
        }
    }
}

// MARK: - Country Delegate
extension AddNewAddressViewController: CitiesDelegate {
    func citySelected(cityModel: CityModel) {
        self.areaModel = nil
        self.cityModel = cityModel
        updateAddAddressButtonAppearence()
        self.tableView.reloadData()
    }
}

// MARK: - City Delegate
extension AddNewAddressViewController: CountriesDelegate {
    func countrySelected(countryModel: CountryModel) {
        self.cityModel = nil
        self.countryModel = countryModel
        updateAddAddressButtonAppearence()
        self.tableView.reloadData()
    }
}

// MARK: - Area Delegate
extension AddNewAddressViewController: AreasDelegate {
    func areaSelected(areaModel: AreaModel) {
        self.areaModel = areaModel
        updateAddAddressButtonAppearence()
        self.tableView.reloadData()
    }
}

// MARK: - Address Detailed Delegate
extension AddNewAddressViewController: AddNewAddressDetailsDelegate {
    func addressChanged(address: String) {
        detailedAddress = address
        updateAddAddressButtonAppearence()
        self.tableView.reloadData()
    }
}
