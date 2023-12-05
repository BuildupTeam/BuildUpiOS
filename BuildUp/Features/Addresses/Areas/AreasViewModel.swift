//
//  AreasViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import Foundation

class AreasViewModel: BaseViewModel {
    
    weak var service: AreasWebServiceProtocol?
    var areas: [AreaModel]?

    var cityModel: CityModel?
    public var onAreas: (() -> Void)?

    init(service: AreasWebServiceProtocol = AreasWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getAreas(cityId: Int) {
        guard let service = service else {
            return
        }
        
        service.getAreas(cityId: cityId) { (result) in
            switch result {
            case .success(let response):
                self.areas = response.data
                self.onAreas?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
