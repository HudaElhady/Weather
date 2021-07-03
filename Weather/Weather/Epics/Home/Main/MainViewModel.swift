//
//  MainViewModel.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation

class MainViewModel: BaseViewModel {

    var city:Dynamic<HomeCity> = Dynamic(HomeCity())
    var errorMessage: Dynamic<String> = Dynamic("")
    let locationManager: LocationManager
    var locationStatus: NSKeyValueObservation?
    var location: NSKeyValueObservation?
    
    
    
    init(locationManager: LocationManager = LocationManager()) {
        self.locationManager = locationManager
        self.locationManager.initLocationManager()
        super.init(isLoading: false)
    }
    
    func getCurrentCity() {
        location = locationManager.observe(\LocationManager.currentLocation, options: .new) { (location, change) in
            guard let currentLocation = location.currentLocation else {
                return
            }
            self.locationManager.getCityName(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude) { city in
                if let city = city {
                    self.city.value = HomeCity(name: city, lat: currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude)
                }
            }

        }
        
        locationStatus = locationManager.observe(\LocationManager.isLocationEnabled, options: .new) { (location, change) in
            if !location.isLocationEnabled {
                self.city.value = HomeCity(name: "London", lat: Constants.LondonLocation.latitude, long: Constants.LondonLocation.longitude)
            }
        }

    }
}
