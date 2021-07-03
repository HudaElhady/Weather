//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    static let identifier = "ForecastTableViewCell"

    func configure(forecast: DailyForecast) {
        dateLabel.text = forecast.date
        tempLabel.text = forecast.tempreature
        descriptionLabel.text = forecast.description
    }
}
