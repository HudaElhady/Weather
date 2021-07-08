//
//  ForecastRepo.swift
//  Weather
//
//  Created by huda elhady on 08/07/2021.
//

import Foundation

protocol ForecastRepo {
    func getForecast(lat: Double, long: Double, completionHandler: @escaping (Result<ForecastResponse,NetworkError>)->Void)
    func getCities(by name: String, completionHandler: @escaping (Result<CityResponse,NetworkError>)->Void)
}

class ForecastRepoImpl: ForecastRepo {
    
    func getForecast(lat: Double, long: Double, completionHandler: @escaping (Result<ForecastResponse,NetworkError>)->Void) {
        URLSession.shared.load(ForecastResources.forecastResource(lat: lat, long: long)) {response in
            switch response {
            case .success(let docs):
                completionHandler(.success(docs))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getCities(by name: String, completionHandler: @escaping (Result<CityResponse,NetworkError>)->Void) {
        URLSession.shared.load(CityResources.cityResource(searchString: name)) {response in
            switch response {
            case .success(let docs):
                completionHandler(.success(docs))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
