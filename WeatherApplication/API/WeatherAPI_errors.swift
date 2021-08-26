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

class WeatherAPI_errors {
    
    static let shared = WeatherAPI_errors()
    static var trigger = 0
    static var cityStatic = "Casablanca"
    static var coordinates = [0.0, 0.0]
    static var getLocationOnView = false
    static var numberOfRows = 0
    
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
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherDetail, APIError> {
        StaticContext.cityStatic = city
        
        guard let url = absoluteURL(city: city) else {
            return Fail(error: APIError.url)
                .eraseToAnyPublisher()
        }
        return
            
            URLSession.shared.dataTaskPublisher(for:url)
            .mapError {_ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<WeatherDetail, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
               
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: WeatherDetail.self, decoder: jsonDecoder)
                        .mapError {_ in APIError.decodingError }
                        .eraseToAnyPublisher()
                    
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    //MARK: - Fetch weather by latitude and longitude
    
    func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherDetail, APIError> {
        StaticContext.coordinates = [latitude, longitude]
        
        guard let url = absoluteURL(latitude: latitude, longitude: longitude) else {
            return Fail(error: APIError.url)
                .eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .mapError {_ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<WeatherDetail, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
               
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: WeatherDetail.self, decoder: jsonDecoder)
                        .mapError {_ in APIError.decodingError }
                        .eraseToAnyPublisher()
                    
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
