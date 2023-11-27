//
//  AddNewAddressViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation

class AddNewAddressViewModel: BaseViewModel {
    
    weak var service: AddNewAddressWebServiceProtocol?

    public var onAddNewAddress: (() -> Void)?
    public var addressUpdated: (() -> Void)?

    init(service: AddNewAddressWebServiceProtocol = AddNewAddressWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func addNewAddress(countryId: Int, cityId: Int, areaId: Int, address: String) {
        guard let service = service else {
            return
        }
        
        service.addNewAddress(countryId: countryId, cityId: cityId, areaId: areaId, address: address) { (result) in
            switch result {
            case .success(_):
                self.onAddNewAddress?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
    
    func updateAddress(addressId: Int, countryId: Int, cityId: Int, areaId: Int, address: String) {
        guard let service = service else {
            return
        }
        
        service.updateAddress(addressId: addressId, countryId: countryId, cityId: cityId, areaId: areaId, address: address) { (result) in
            switch result {
            case .success(_):
                self.addressUpdated?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
