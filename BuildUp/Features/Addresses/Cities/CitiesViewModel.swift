//
//  CitiesViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import Foundation

class CitiesViewModel: BaseViewModel {
    
    weak var service: CitiesWebServiceProtocol?
    var cities: [CityModel]?

    public var onCities: (() -> Void)?

    init(service: CitiesWebServiceProtocol = CitiesWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getCities(countryId: Int) {
        guard let service = service else {
            return
        }
        
        service.getCities(countryId: countryId) { (result) in
            switch result {
            case .success(let response):
                self.cities = response.data
                self.onCities?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
