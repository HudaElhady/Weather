//
//  DocumentsRepoMock.swift
//  WeatherTests
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation
@testable import Weather

class ForecastRepoMock: BaseRepoMock, ForecastRepo {
    
    var getForecastSuccess: ForecastResponse!
    func getForecast(lat: Double, long: Double, completionHandler: @escaping (Result<ForecastResponse,NetworkError>)->Void) {
        shouldSuccess ? completionHandler(.success(getForecastSuccess)) : completionHandler(.failure(failReponse))
    }
    
    var getCitiesSuccess: CityResponse!
    func getCities(by name: String, completionHandler: @escaping (Result<CityResponse,NetworkError>)->Void) {
        shouldSuccess ? completionHandler(.success(getCitiesSuccess)) : completionHandler(.failure(failReponse))
    }
}
