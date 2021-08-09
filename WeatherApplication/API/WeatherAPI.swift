//
//  WeaatherAPI.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//

import Foundation
import Combine
import UIKit
import CoreLocation

class WeatherAPI {
    static let shared = WeatherAPI()
    
    private let baseaseURL = "https://api.openweathermap.org/data/2.5/forecast"
//    "https://api.openweathermap.org/data/2.5/forecast?appid=b630bd827224a431dcb7ff436690839b&q=Minsk"
    private let apiKey = "b630bd827224a431dcb7ff436690839b"
    
    private func absoluteURL(city: String) -> URL? {
        let queryURL = URL(string: baseaseURL)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil}
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
                                    URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    private func absoluteURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
        let queryURL = URL(string: baseaseURL)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil}
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
                                    URLQueryItem(name: "lat", value: "\(latitude)"),
                                    URLQueryItem(name: "lon", value: "\(longitude)"),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    
    
       func fetchWeather(for city: String) -> AnyPublisher<WeatherDetail, Never> {

           guard let url = absoluteURL(city: city) else {                  // 1
            return Just(WeatherDetail.placeholder)
                   .eraseToAnyPublisher()
           }
           return
               URLSession.shared.dataTaskPublisher(for:url)                  
                   .map { $0.data }
                   .decode(type: WeatherDetail.self, decoder: JSONDecoder())
                   .catch { error in Just(WeatherDetail.placeholder)}
                   .receive(on: RunLoop.main)
                   .eraseToAnyPublisher()
       }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> AnyPublisher<WeatherDetail, Never> {

        guard let url = absoluteURL(latitude: latitude, longitude: longitude) else {
         return Just(WeatherDetail.placeholder)
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
                .map { $0.data }
                .decode(type: WeatherDetail.self, decoder: JSONDecoder())
                .catch { error in Just(WeatherDetail.placeholder)}
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
}

