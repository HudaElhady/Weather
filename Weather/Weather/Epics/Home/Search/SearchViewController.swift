//
//  SearchViewController.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    private var viewModel: SearchViewModel!
    private var cities = [HomeCity]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var didSelectCityHandler: ((HomeCity)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel()
        setupObservables()
        setupSearchController()
    }
    
    func setupObservables() {
        viewModel.citiestArr.bind { [weak self](citiestArr) in
            self?.cities = citiestArr
            self?.tableView.reloadData()
        }
        
        viewModel.errorMessage.bind { errorMessage in
            self.alert(message: errorMessage, actions: [(Constants.MessagesStrings.ok, .cancel)])
        }
        
        viewModel.isLoading.bindAndFire { (isLoading) in
            if isLoading { self.activityLoader.startSpinner()} else { self.activityLoader.stopSpinner()}
        }
    }
    
    func setupSearchController() {
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.delegate = self
    }
    
    static func create(handler: @escaping (HomeCity)->()) -> SearchViewController? {
        if let vc = UIStoryboard(name: StoryBoardsIDs.main.id, bundle: nil).instantiateViewController(withIdentifier: ViewControllersIDs.searchVC.id) as? SearchViewController {
            vc.didSelectCityHandler = handler
            return vc
        }
        return nil
    }
    
}

extension SearchViewController: UITableViewDataSource {

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

}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        didSelectCityHandler?(city)
        DispatchQueue.main.async {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}



extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getCities(name: searchController.searchBar.text ?? "")
        searchController.searchBar.resignFirstResponder()
    }
}


