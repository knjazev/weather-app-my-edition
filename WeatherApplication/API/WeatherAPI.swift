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
    
    static var trigger = 0
    static var cityStatic = "Riga"
    static var coordinates = [0.0, 0.0]
    static var numberOfSections = 0
    static var numberOfRows = 0
    
    
    private let baseaseURL = "https://api.openweathermap.org/data/2.5/forecast"
    //"https://api.openweathermap.org/data/2.5/forecast?appid=b630bd827224a431dcb7ff436690839b&q=Minsk&units=metric"
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
        WeatherAPI.cityStatic = city
        
        guard let url = absoluteURL(city: city) else {
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
    
    
        func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherDetail, Never> {
            WeatherAPI.coordinates = [latitude, longitude]
    
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
