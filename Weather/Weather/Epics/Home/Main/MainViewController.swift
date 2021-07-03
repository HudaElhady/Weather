//
//  MainViewController.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    private var viewModel: MainViewModel!
    private var cities = [HomeCity]()
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupObservables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupObservables() {
        viewModel.city.bind { [weak self](city) in
            self?.updateDataSource(city: city)
        }
    }
    
    private func updateDataSource(city: HomeCity){
        cities.append(city)
        tableView.reloadData()
    }
    
    @IBAction func openSearch(_ sender: UIButton) {
        let vc = SearchViewController.create { [weak self] in
            self?.updateDataSource(city: $0)
        }
        self.present(vc!, animated: true, completion: nil)
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
        return UIScreen.main.bounds.height / 8.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        navigationController?.pushViewController(ForecastViewController.create(latitude: city.lat, longtitude: city.long)!, animated: true)
    }

}


