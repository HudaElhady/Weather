//
//  ForecastViewModel.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation

class ForecastViewModel: BaseViewModel {

    private let forecastRepo: ForecastRepo
    var forecastArr:Dynamic<[DailyForecast]> = Dynamic([DailyForecast]())
    var errorMessage: Dynamic<String> = Dynamic("")
    
    init(forecastRepo: ForecastRepo = ForecastRepoImpl()) {
        self.forecastRepo = forecastRepo
        super.init(isLoading: true)
    }
    

    func getForecast(latitude: Double, longatitude: Double) {
        forecastRepo.getForecast(lat: latitude, long: longatitude) {  (result) in
            self.stopLoading()
            switch result {
            case .success(let response):
                if let dailyArray = response.daily {
                    self.forecastArr.value = dailyArray.map{self.toDailyForecast($0)}
                }
            case .failure(let error):
                self.errorMessage.value = error.errorMessage
            }
        }
    }
    
    func toDailyForecast(_ forecast: Daily) -> DailyForecast {
        let dateString = DateManager.convertToDateString(forecast.dt ?? 0)
        return DailyForecast(date: dateString, tempreature: "\(forecast.temp?.day ?? 0)", description: forecast.weather?[0].descriptionField ?? "")
    }

}
