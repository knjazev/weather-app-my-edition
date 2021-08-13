//
//  WeatherAPI.swift
//  WeatherAppSwiftUI
//
//  Created by UPIT on 12.08.21.
//

import Foundation
import Combine

class WeatherAPI {
    static let shared = WeatherAPI()
    
    private let baseaseURL = "https://api.openweathermap.org/data/2.5/forecast"
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
    

    func fetchWeather(for city: String) -> AnyPublisher<WeatherDetail, Never> {
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
    
}
