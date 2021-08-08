//
//  ViewModel.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//

import Combine
import Foundation

final class ViewModel: ObservableObject {
    // input
    @Published var city: String = "Minsk"
    // output
    @Published var currentWeather = WeatherDetail.placeholder
    @Published var humidity = WeatherDetail.placeholder
    @Published var pressure = WeatherDetail.placeholder
    @Published var weatherConditionID: Int = 800
    

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
    
    init() {
        $city
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city:String) -> AnyPublisher <WeatherDetail, Never> in
                WeatherAPI.shared.fetchWeather(for: city)
              }
             .assign(to: \.currentWeather , on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
   
}
