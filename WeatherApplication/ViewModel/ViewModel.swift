//
//  ViewModel.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//

import Combine
import Foundation
import CoreLocation

final class ViewModel: NSObject, ObservableObject {
    // input
    @Published var city: String = "Minsk"
    @Published var coordinates: [CLLocationDegrees] = [CLLocationDegrees(0.0), CLLocationDegrees(0.0)]
    // output
    @Published var currentWeather = WeatherDetail.placeholder
    @Published var humidity = WeatherDetail.placeholder
    @Published var pressure = WeatherDetail.placeholder
    @Published var weatherConditionID: Int = 800
    
    @Published var cityName = WeatherDetail.placeholder
    @Published var latitude = 0.0
    @Published var longitude = 0.0
    
    let locationManager = CLLocationManager()
    
    
 
    var weatherConditionName: String {
        switch weatherConditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    func getweatherConditionName(weatherConditionID: Int) -> String {
        switch weatherConditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
    func delegateLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    override init() {
        super.init()
        
        $city
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city:String) -> AnyPublisher <WeatherDetail, Never> in
                WeatherAPI.shared.fetchWeather(for: city)
              }
             .assign(to: \.currentWeather, on: self)
            .store(in: &self.cancellableSet)
        

        $coordinates
         .debounce(for: 0.3, scheduler: RunLoop.main)
         .removeDuplicates()
         .flatMap { (coordinates: [CLLocationDegrees]) -> AnyPublisher <WeatherDetail, Never> in
             WeatherAPI.shared.fetchWeather(latitude: coordinates[0], longitude: coordinates[1])
           }
          .assign(to: \.currentWeather , on: self)
         .store(in: &self.cancellableSet2)
        
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var cancellableSet2: Set<AnyCancellable> = []

}


//MARK: - CLLocationManagerDelegate

extension ViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon  = location.coordinate.longitude
//            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}





