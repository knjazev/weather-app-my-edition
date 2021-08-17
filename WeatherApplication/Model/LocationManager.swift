//
//  LocationManager.swift
//  WeatherApplication
//
//  Created by UPIT on 13.08.21.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var coordinates: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    @Published var currentLocation = WeatherDetail.placeholder

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
            $coordinates
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
                .flatMap { (coordinates: CLLocation) -> AnyPublisher <WeatherDetail, Never> in
                    WeatherAPI.shared.fetchWeather(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
            }
            .assign(to: \.currentLocation, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []

   
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
    }
}
