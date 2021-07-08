//
//  CityTableViewCell.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    static let identifier = "CityTableViewCell"

    func configure(city: HomeCity) {
        cityLabel.text = city.name
        coordinateLabel.text = "Geo coords: [\(city.lat) , \(city.long)]"
    }
}
