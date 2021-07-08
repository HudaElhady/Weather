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
    private var citiesList = [HomeCity]() {
        didSet {
            CommonClass.sharedInstance.updateHomeCities(list: citiesList)
        }
    }
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupObservables()
        viewModel.getCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupObservables() {
        viewModel.citiesList.bind { [weak self](cities) in
            self?.updateDataSource(cities)
        }
    }
    
    private func updateDataSource(_ cities: [HomeCity]){
        citiesList.append(contentsOf: cities)
        tableView.reloadData()
    }
    
    @IBAction func openSearch(_ sender: UIButton) {
        let vc = SearchViewController.create { [weak self] in
            self?.updateDataSource([$0])
        }
        self.present(vc!, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell {
            cell.configure(city: citiesList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = citiesList[indexPath.row]
        navigationController?.pushViewController(ForecastViewController.create(latitude: city.lat, longtitude: city.long)!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            citiesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}


