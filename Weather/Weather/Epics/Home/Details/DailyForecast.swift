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
    
}
