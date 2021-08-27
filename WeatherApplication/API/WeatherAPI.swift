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

//struct Objects: Hashable {
//    var sectionName: String
//    var sectionObjects: [String]
//}

class WeatherAPI {
    
    static let shared = WeatherAPI()

    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    private let apiKey = "b630bd827224a431dcb7ff436690839b"
    
    //MARK: - URL for city fetching
    
    private func absoluteURL(city: String) -> URL? {
        let queryURL = URL(string: baseURL)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil}
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
                                    URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    
    //MARK: - URL for latitude and longitude fetching
    
    private func absoluteURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
        let queryURL = URL(string: baseURL)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil}
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
                                    URLQueryItem(name: "lat", value: "\(latitude)"),
                                    URLQueryItem(name: "lon", value: "\(longitude)"),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    
    //MARK: - Fetch weather by city
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherDetail, Never> {
        StaticContext.cityStatic = city
        
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
    
    //MARK: - Fetch weather by latitude and longitude
    
    func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherDetail, Never> {
        StaticContext.coordinates = [latitude, longitude]
        
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
