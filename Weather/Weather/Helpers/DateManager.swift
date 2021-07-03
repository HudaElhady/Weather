//
//  DateManager.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation

class DateManager {
    static func convertToDateString(_ dateInt: Int, format: String = "yyyy-MM-dd") -> String {
        let time = TimeInterval(dateInt) / 1000
        let date = Date(timeIntervalSince1970: time)
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: date)
    }
}