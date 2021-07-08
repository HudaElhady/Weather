//
//  ForecastViewController.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    private var latitude: Double?
    private var longatitude: Double?
    private var viewModel: ForecastViewModel!
    private var forecastArr = [DailyForecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ForecastViewModel()
        setupObservables()
        viewModel.getForecast(latitude: latitude ?? 0, longatitude: longatitude ?? 0)
        initUI()
    }
    
    func initUI()  {
        navigationItem.title = Constants.MessagesStrings.forecastTitle
        navigationController?.navigationBar.isHidden = false
    }
    
    static func create(latitude: Double, longtitude: Double) -> ForecastViewController? {
        if let vc = UIStoryboard(name: StoryBoardsIDs.main.id, bundle: nil).instantiateViewController(withIdentifier: ViewControllersIDs.forecastVC.id) as? ForecastViewController {
            vc.latitude = latitude
            vc.longatitude = longtitude
            return vc
        }
        return nil
    }
    
    func setupObservables() {
            viewModel.isLoading.bindAndFire { (isLoading) in
                if isLoading { self.activityLoader.startSpinner()} else { self.activityLoader.stopSpinner()}
            }
            viewModel.forecastArr.bind { [weak self](forecast) in
                self?.forecastArr = (forecast)
                self?.tableView.reloadData()
            }
            
            viewModel.errorMessage.bind { errorMessage in
                self.alert(message: errorMessage, actions: [("OK", .cancel)])
            }
        }

}

extension ForecastViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as? ForecastTableViewCell {
            cell.configure(forecast: forecastArr[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    

}

extension ForecastViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8.5
    }
}

