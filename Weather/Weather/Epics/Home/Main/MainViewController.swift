//
//  MainViewController.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MainViewModel!
    private var cities = [HomeCity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        LocationManager.manager.initLocationManager()
        viewModel = MainViewModel()
        viewModel.getCurrentCity()
        setupObservables()
    }
    func setupObservables() {
        viewModel.city.bind { [weak self](city) in
            self?.cities.append(city)
            self?.tableView.reloadData()
        }
        
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell {
            cell.configure(city: cities[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        navigationController?.pushViewController(ForecastViewController.create(latitude: city.lat, longtitude: city.long)!, animated: true)
    }

}


