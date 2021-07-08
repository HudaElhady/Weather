//
//  MainViewModel.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation
import CoreLocation

class MainViewModel: BaseViewModel {

    var citiesList:Dynamic<[HomeCity]> = Dynamic([HomeCity]())
    var errorMessage: Dynamic<String> = Dynamic("")
    private let locationManager: LocationManager
    private let localDBRepo: LocalDBRepo
    
    
    init(localDBRepo: LocalDBRepo = LocalDBRepoImpl(), locationManager: LocationManager = LocationManager()) {
        self.locationManager = locationManager
        self.localDBRepo = localDBRepo
        super.init(isLoading: false)
    }
    
    func getCities() {
        startLoading()
        localDBRepo.getCities { [weak self](result) in
            self?.stopLoading()
            switch result {
            case .success(let response):
                if response.count > 0 {
                    self?.citiesList.value = response
                } else {
                    self?.setupLocation()
                }
                self?.localDBRepo.deleteAllCities()
            case .failure(let error):
                self?.errorMessage.value = error.errorMessage
                self?.setupLocation()
            }
        }
    }
    
    private func setupLocation() {
        self.locationManager.initLocationManager(didUpdateLocation: {[weak self] in self?.updateLocation(location: $0)}, locationDenied: {[weak self] in self?.locationDenied()})
    }
    
    private func updateLocation(location: CLLocation) {
        self.locationManager.getCityName(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { city in
            if let city = city {
                self.citiesList.value = [HomeCity(name: city, lat: location.coordinate.latitude, long: location.coordinate.longitude)]
            }
        }
    }
    
    private func locationDenied() {
        self.citiesList.value = [HomeCity(name: "London", lat: Constants.LondonLocation.latitude, long: Constants.LondonLocation.longitude)]
    }
    
}
