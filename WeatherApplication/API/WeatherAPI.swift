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
    
    var delegate: WeatherAPIDelegate?
    
    private let baseaseURL = "https://api.openweathermap.org/data/2.5/forecast"
    //"https://api.openweathermap.org/data/2.5/forecast?appid=b630bd827224a431dcb7ff436690839b&q=Minsk"
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
//    private func absoluteURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
//        let queryURL = URL(string: baseaseURL)!
//        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
//        guard var urlComponents = components else { return nil}
//        urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
//                                    URLQueryItem(name: "lat", value: "\(latitude)"),
//                                    URLQueryItem(name: "lon", value: "\(longitude)"),
//                                    URLQueryItem(name: "units", value: "metric")]
//        return urlComponents.url
//    }
    
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
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(baseaseURL)?appid=\(apiKey)&lat=\(latitude)&lon=\(longitude)"
        perfomRequest(with: urlString)
    }
    
    func perfomRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeDate = data {
                    if let cityName  = self.parseJSON(safeDate){
                        self.delegate?.didUpdateWeather(self, cityName: cityName)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ weatherData: Data) -> String? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData =  try decoder.decode(WeatherDetail.self, from: weatherData)
            let name = decodedData.city?.name
            return name
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    //    func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherDetail, Never> {
    //
    //        guard let url = absoluteURL(latitude: latitude, longitude: longitude) else {
    //         return Just(WeatherDetail.placeholder)
    //                .eraseToAnyPublisher()
    //        }
    //        return
    //            URLSession.shared.dataTaskPublisher(for:url)
    //                .map { $0.data }
    //                .decode(type: WeatherDetail.self, decoder: JSONDecoder())
    //                .catch { error in Just(WeatherDetail.placeholder)}
    //                .receive(on: RunLoop.main)
    //                .eraseToAnyPublisher()
    //    }
}

protocol WeatherAPIDelegate {
    func didUpdateWeather(_ weatherAPI: WeatherAPI, cityName: String)
    func didFailWithError(error: Error)
}
