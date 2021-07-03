//
//  ForecastRepo.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation

protocol ForecastRepo {
    func getForecast(lat: Double, long: Double, completionHandler: @escaping (Result<ForecastResponse,NetworkError>)->Void)
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
    
}
