//
//  ForecastResources.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation

struct ForecastResources {
    
    static func forecastResource(lat: Double, long: Double) -> Resource<ForecastResponse> {
        let urlString = Constants.Api.baseUrl + "onecall?exclude=current,minutely,hourly" + "&lat=\(lat)&lon=\(long)&appid=\(Constants.Api.appId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
       return Resource<ForecastResponse>(get: URL(string: urlString)!)
    }
}
