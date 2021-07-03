//
//  SearchViewModel.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation

class SearchViewModel: BaseViewModel {

    private let forecastRepo: ForecastRepo
    var citiestArr:Dynamic<[HomeCity]> = Dynamic([HomeCity]())
    var errorMessage: Dynamic<String> = Dynamic("")
    
    init(forecastRepo: ForecastRepo = ForecastRepoImpl()) {
        self.forecastRepo = forecastRepo
        super.init(isLoading: false)
    }
    

    func getCities(name: String) {
        self.startLoading()
        forecastRepo.getCities(by: name) {  (result) in
            self.stopLoading()
            switch result {
            case .success(let response):
                if let list = response.list, list.count > 0 {
                    self.citiestArr.value = list.map{HomeCity(name: $0.name ?? "", lat: $0.coord?.lat ?? 0, long: $0.coord?.lon ?? 0)}
                }
            case .failure(let error):
                self.errorMessage.value = error.errorMessage
            }
        }
    }
    
}
