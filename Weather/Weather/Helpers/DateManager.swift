//
//  DateManager.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation

class DateManager {
    static func convertToDateString(_ dateInt: Int, format: String = "yyyy-MM-dd") -> String {
        let date = Date(timeIntervalSince1970: Double(dateInt))
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        return format.string(from: date)
    }
}
