//
//  CountiresViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import Foundation

class CountiresViewModel: BaseViewModel {
    
    weak var service: CountriesWebServiceProtocol?
    var countries: [CountryModel]?

    public var onCountries: (() -> Void)?

    init(service: CountriesWebServiceProtocol = CountriesWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getCountries() {
        guard let service = service else {
            return
        }
        
        service.getCountries() { (result) in
            switch result {
            case .success(let response):
                self.countries = response.data
                self.onCountries?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
