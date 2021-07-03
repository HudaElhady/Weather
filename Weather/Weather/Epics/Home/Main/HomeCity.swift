//
//  HomeCity.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation

class HomeCity {
    let name: String
    let lat: Double
    let long: Double
    
    init() {
        name = ""
        lat = 0
        long = 0
    }
    
    init(name: String, lat: Double, long: Double) {
        self.name = name
        self.lat = lat
        self.long = long
    }
    
}
