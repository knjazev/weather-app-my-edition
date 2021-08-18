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
    @Published var city: String = WeatherAPI.cityStatic
    @Published var coordinates = WeatherAPI.coordinates
    // output
    @Published var currentWeather = WeatherDetail.placeholder

    @Published var currentWeather2 = WeatherDetail.placeholder
    
    
    
    @Published var humidity = WeatherDetail.placeholder
    @Published var pressure = WeatherDetail.placeholder
    @Published var temperature = WeatherDetail.placeholder
    @Published var weatherConditionID: Int = 800
    
    private var cancellableSet: Set<AnyCancellable> = []

    let locationManager = CLLocationManager()
    var weatherAPI = WeatherAPI()
    
    var weatherConditionName: String {
        switch weatherConditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.rain"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    func getweatherConditionName(weatherConditionID: Int) -> String {
        switch weatherConditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.rain"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    
        func delegatation() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
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
            .flatMap { (coordinate: [Double]) -> AnyPublisher <WeatherDetail, Never> in
                     WeatherAPI.shared.fetchWeather(latitude: coordinate[0], longitude: coordinate[1])
            }
//            .assign(to: \.currentWeather2, on: self)
            .assign(to: \.currentWeather2, on: self)
            .store(in: &self.cancellableSet)
        
    
   
}

 
}


//MARK: - CLLocationManagerDelegate

extension ViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("from didUpdateLocations: lat: \(location.coordinate.latitude), lon: \(location.coordinate.longitude)")
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon  = location.coordinate.longitude
                
            weatherAPI.fetchWeather(latitude: lat, longitude: lon)

            
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}
