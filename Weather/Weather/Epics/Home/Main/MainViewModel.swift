//
//  MainViewModel.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation
import CoreLocation

class MainViewModel: BaseViewModel {

    var city:Dynamic<HomeCity> = Dynamic(HomeCity())
    var errorMessage: Dynamic<String> = Dynamic("")
    private let locationManager: LocationManager
    
    
    
    init(locationManager: LocationManager = LocationManager()) {
        self.locationManager = locationManager
        super.init(isLoading: false)
        setupLocation()
    }
    
    private func setupLocation() {
        self.locationManager.initLocationManager(didUpdateLocation: {[weak self] in self?.updateLocation(location: $0)}, locationDenied: {[weak self] in self?.locationDenied()})
    }
    
    private func updateLocation(location: CLLocation) {
        self.locationManager.getCityName(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { city in
            if let city = city {
                self.city.value = HomeCity(name: city, lat: location.coordinate.latitude, long: location.coordinate.longitude)
            }
        }
    }
    
    private func locationDenied() {
        self.city.value = HomeCity(name: "London", lat: Constants.LondonLocation.latitude, long: Constants.LondonLocation.longitude)
    }
    
}
