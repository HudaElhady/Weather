//
//  LocationManager.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import CoreLocation

//class LocationManager {
//    static var manager: LocationManagerHelper = LocationManagerHelper()
//}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    @objc dynamic var currentLocation: CLLocation?
    @objc dynamic var isLocationEnabled = false
    
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        currentLocation = location
        manager.delegate = nil
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            isLocationEnabled = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location status is OK.")
            isLocationEnabled = true
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}


extension LocationManager {
    func getCityName(latitude: Double, longitude: Double, handler: @escaping (String?)->()) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            guard let placemarks = placemarks, let placemark = placemarks.first else {
                handler(nil)
                return
            }
            handler(placemark.locality ?? placemark.name)
            
        })
    }
}

