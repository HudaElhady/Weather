//
//  StoryBoardsIDs.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation

enum StoryBoardsIDs: String {
    case main = "Main"
    
    var id: String {
        return self.rawValue
    }
}

enum ViewControllersIDs: String {
    case forecastVC = "ForecastViewController"
    
    var id: String {
        return self.rawValue
    }
}
