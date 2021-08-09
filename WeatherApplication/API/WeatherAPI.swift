//
//  WeaatherAPI.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//

import Foundation
import Combine
import UIKit

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
    
       func fetchWeather(for city: String) -> AnyPublisher<WeatherDetail, Never> {

           guard let url = absoluteURL(city: city) else {                  // 1
            return Just(WeatherDetail.placeholder)
                   .eraseToAnyPublisher()
           }
           return
               URLSession.shared.dataTaskPublisher(for:url)                  // 2
                   .map { $0.data }                                          // 3
                   .decode(type: WeatherDetail.self, decoder: JSONDecoder()) // 4
                   .catch { error in Just(WeatherDetail.placeholder)}        // 5
                   .receive(on: RunLoop.main)                                // 6
                   .eraseToAnyPublisher()                                    // 7
       }
}

