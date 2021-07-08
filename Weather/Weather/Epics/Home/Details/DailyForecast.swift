//
//  DailyForecast.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation

class DailyForecast {
    let date: String
    let tempreature: String
    let description: String
    
    init() {
        date = ""
        tempreature = ""
        description = ""
    }
    
    init(date: String, tempreature: String, description: String) {
        self.date = date
        self.tempreature = tempreature
        self.description = description
    }
    
    static func makeDailyForecast(from forecast: Daily) ->  DailyForecast {
        let dateString = DateManager.convertToDateString(forecast.dt ?? 0)
        return DailyForecast(date: dateString, tempreature: "\(forecast.temp?.day ?? 0)", description: forecast.weather?[0].descriptionField ?? "")
    }
    
}
