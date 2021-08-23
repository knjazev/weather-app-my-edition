//
//  Extensions.swift
//  WeatherApplication
//
//  Created by UPIT on 23.08.21.
//

import Foundation
import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}

// With errors
//extension UITextField {
//    var textPublisher: AnyPublisher<String, APIError> {
//        NotificationCenter.default
//            .publisher(for: UITextField.textDidChangeNotification, object: self)
//            .compactMap { $0.object as? UITextField }
//            .setFailureType(to: APIError.self)
//            .map { $0.text ?? "" }
//            .eraseToAnyPublisher()
//    }
//}

extension UIColor {
    struct ElementColor {
        static var sunColor: UIColor  { return UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1) }
        static var cloudColor: UIColor { return UIColor(red: 232/255, green: 182/255, blue: 182/255, alpha: 1)}
        static var rainColor: UIColor { return UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1) }
        static var thunderColor: UIColor { return UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1) }
        static var fogColor: UIColor { return UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)}
        static var snowColor: UIColor { return UIColor(red: 83/255, green: 100/255, blue: 135/255, alpha: 1) }
    }
    
    struct BackgroundColor {
        static var sunColor: UIColor  { return UIColor(red: 254/255, green: 202/255, blue: 202/255, alpha: 1) }
        static var cloudColor: UIColor { return UIColor(red: 6/255, green: 128/255, blue: 93/255, alpha: 1) }
        static var rainColor: UIColor { return UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1) }
        static var thunderColor: UIColor { return UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1) }
        static var fogColor: UIColor { return UIColor(red: 182/255, green: 182/255, blue: 183/255, alpha: 1) }
        static var snowColor: UIColor { return UIColor(red: 172/255, green: 217/255, blue: 242/255, alpha: 1) }
    }
    
    struct BackgroundColorDark {
        static var sunColor: UIColor  { return UIColor(red: 126/255, green: 100/255, blue: 100/255, alpha: 1) }
        static var cloudColor: UIColor { return UIColor(red: 2/255, green: 63/255, blue: 46/255, alpha: 1) }
        static var rainColor: UIColor { return UIColor(red: 5/255, green: 48/255, blue: 120/255, alpha: 1) }
        static var thunderColor: UIColor { return UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1) }
        static var fogColor: UIColor { return UIColor(red: 90/255, green: 90/255, blue: 91/255, alpha: 1) }
        static var snowColor: UIColor { return UIColor(red: 85/255, green: 108/255, blue: 120/255, alpha: 1) }
    }
    
    struct ElementColorDark {
        static var sunColor: UIColor  { return UIColor(red: 127/255, green: 58/255, blue: 30/255, alpha: 1) }
        static var cloudColor: UIColor { return UIColor(red: 126/255, green: 76/255, blue: 84/255, alpha: 1)}
        static var rainColor: UIColor { return UIColor(red: 0/255, green: 108/255, blue: 127/255, alpha: 1) }
        static var thunderColor: UIColor { return UIColor(red: 123/255, green: 117/255, blue: 62/255, alpha: 1) }
        static var fogColor: UIColor { return UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)}
        static var snowColor: UIColor { return UIColor(red: 40/255, green: 50/255, blue: 69/255, alpha: 1) }
    }
}

extension UIViewController {
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        else {
            return false
        }
    }
}

extension ViewController {
    
    func setClearLightState() {
        view.backgroundColor = UIColor.BackgroundColor.sunColor
        
        getLocationButton.setImage(UIImage(named: "location.sun.max"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.sunColor
        
        tempImageLabel.image = UIImage(named: "temp.sun.max")
        windImageLabel.image = UIImage(named: "wind.sun.max")
        humidityImageLabel.image = UIImage(named: "humidity.sun.max")
        pressureImageLabel.image = UIImage(named: "pressure.sun.max")
        
        cityLabel.textColor = UIColor.ElementColor.sunColor
        temperatureLabel.textColor = UIColor.ElementColor.sunColor
        humidityLabel.textColor = UIColor.ElementColor.sunColor
        pressureLabel.textColor = UIColor.ElementColor.sunColor
        windLabel.textColor = UIColor.ElementColor.sunColor
        textField.backgroundColor = UIColor.ElementColor.sunColor
        switchButton.tintColor = UIColor.ElementColor.sunColor
        shareButton.tintColor = UIColor.ElementColor.sunColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.sunColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.sunColor
        textField.textColor = UIColor.BackgroundColor.sunColor
    }
    func setRainLightState() {
        view.backgroundColor = UIColor.BackgroundColor.rainColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.rainColor
        tempImageLabel.image = UIImage(named: "temp.cloud.rain")
        windImageLabel.image = UIImage(named: "wind.cloud.rain")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
        
        cityLabel.textColor = UIColor.ElementColor.rainColor
        temperatureLabel.textColor = UIColor.ElementColor.rainColor
        humidityLabel.textColor = UIColor.ElementColor.rainColor
        pressureLabel.textColor = UIColor.ElementColor.rainColor
        windLabel.textColor = UIColor.ElementColor.rainColor
        textField.backgroundColor = UIColor.ElementColor.rainColor
        textField.textColor = UIColor.BackgroundColor.rainColor
        switchButton.tintColor = UIColor.ElementColor.rainColor
        shareButton.tintColor = UIColor.ElementColor.rainColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.rainColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.rainColor
    }
    
    func setCloudsLightState() {
        view.backgroundColor = UIColor.BackgroundColor.cloudColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.cloudColor
        tempImageLabel.image = UIImage(named: "temp.cloud")
        windImageLabel.image = UIImage(named: "wind.cloud")
        humidityImageLabel.image = UIImage(named: "humidity.cloud")
        pressureImageLabel.image = UIImage(named: "pressure.cloud")
        weatherConditionImage.image = UIImage(named: "cloud")
        
        
        cityLabel.textColor = UIColor.ElementColor.cloudColor
        temperatureLabel.textColor = UIColor.ElementColor.cloudColor
        humidityLabel.textColor = UIColor.ElementColor.cloudColor
        pressureLabel.textColor = UIColor.ElementColor.cloudColor
        windLabel.textColor = UIColor.ElementColor.cloudColor
        textField.backgroundColor = UIColor.ElementColor.cloudColor
        textField.textColor = UIColor.BackgroundColor.cloudColor
        switchButton.tintColor = UIColor.ElementColor.cloudColor
        shareButton.tintColor = UIColor.ElementColor.cloudColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.cloudColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.cloudColor
    }
    
    func setThunderLightState() {
        view.backgroundColor = UIColor.BackgroundColor.thunderColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.bolt"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.thunderColor
        tempImageLabel.image = UIImage(named: "temp.cloud.bolt")
        windImageLabel.image = UIImage(named: "wind.cloud.bolt")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")
        
        cityLabel.textColor = UIColor.ElementColor.thunderColor
        
        temperatureLabel.textColor = UIColor.ElementColor.thunderColor
        humidityLabel.textColor = UIColor.ElementColor.thunderColor
        pressureLabel.textColor = UIColor.ElementColor.thunderColor
        windLabel.textColor = UIColor.ElementColor.thunderColor
        textField.backgroundColor = UIColor.ElementColor.thunderColor
        textField.textColor = UIColor.BackgroundColor.thunderColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
        shareButton.tintColor = UIColor.ElementColor.thunderColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.thunderColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.bolt")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.thunderColor
    }
    
    func setSnowLightState() {
        view.backgroundColor = UIColor.BackgroundColor.snowColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.snow"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.snowColor
        tempImageLabel.image = UIImage(named: "temp.cloud.snow")
        windImageLabel.image = UIImage(named: "wind.cloud.snow")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")
        
        cityLabel.textColor = UIColor.ElementColor.snowColor
        
        temperatureLabel.textColor = UIColor.ElementColor.snowColor
        humidityLabel.textColor = UIColor.ElementColor.snowColor
        pressureLabel.textColor = UIColor.ElementColor.snowColor
        windLabel.textColor = UIColor.ElementColor.snowColor
        textField.backgroundColor = UIColor.ElementColor.snowColor
        textField.textColor = UIColor.BackgroundColor.snowColor
        switchButton.tintColor = UIColor.ElementColor.snowColor
        shareButton.tintColor = UIColor.ElementColor.snowColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.snowColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.snow")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.snowColor
    }
    
    func setFogLightState() {
        view.backgroundColor = UIColor.BackgroundColor.fogColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.fog"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.fogColor
        tempImageLabel.image = UIImage(named: "temp.cloud.fog")
        windImageLabel.image = UIImage(named: "wind.cloud.fog")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")
        
        cityLabel.textColor = UIColor.ElementColor.fogColor
        
        temperatureLabel.textColor = UIColor.ElementColor.fogColor
        humidityLabel.textColor = UIColor.ElementColor.fogColor
        pressureLabel.textColor = UIColor.ElementColor.fogColor
        windLabel.textColor = UIColor.ElementColor.fogColor
        textField.backgroundColor = UIColor.ElementColor.fogColor
        textField.textColor = UIColor.BackgroundColor.fogColor
        switchButton.tintColor = UIColor.ElementColor.fogColor
        shareButton.tintColor = UIColor.ElementColor.fogColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.fogColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.fog")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.fogColor

    }
    
    func setClearDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.sunColor
        
        getLocationButton.setImage(UIImage(named: "location.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.sunColor
        tempImageLabel.image = UIImage(named: "temp.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        windImageLabel.image = UIImage(named: "wind.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        humidityImageLabel.image = UIImage(named: "humidity.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        pressureImageLabel.image = UIImage(named: "pressure.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        weatherConditionImage.image = UIImage(named: "sun.max.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.sunColor
        temperatureLabel.textColor = UIColor.ElementColorDark.sunColor
        humidityLabel.textColor = UIColor.ElementColorDark.sunColor
        pressureLabel.textColor = UIColor.ElementColorDark.sunColor
        windLabel.textColor = UIColor.ElementColorDark.sunColor
        textField.backgroundColor = UIColor.ElementColorDark.sunColor
        textField.textColor = UIColor.BackgroundColorDark.sunColor
        switchButton.tintColor = UIColor.ElementColorDark.sunColor
        shareButton.tintColor = UIColor.ElementColorDark.sunColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.sunColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.sunColor
    }
    func setCloudsDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.cloudColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.cloudColor
        tempImageLabel.image = UIImage(named: "temp.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        windImageLabel.image = UIImage(named: "wind.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        weatherConditionImage.image = UIImage(named: "cloud.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.cloudColor
        temperatureLabel.textColor = UIColor.ElementColorDark.cloudColor
        humidityLabel.textColor = UIColor.ElementColorDark.cloudColor
        pressureLabel.textColor = UIColor.ElementColorDark.cloudColor
        windLabel.textColor = UIColor.ElementColorDark.cloudColor
        textField.backgroundColor = UIColor.ElementColorDark.cloudColor
        textField.textColor = UIColor.BackgroundColorDark.cloudColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
        shareButton.tintColor = UIColor.ElementColorDark.cloudColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.cloudColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.cloudColor
        
    }
    func setRainDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.rainColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.rainColor
        tempImageLabel.image = UIImage(named: "temp.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        windImageLabel.image = UIImage(named: "wind.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        weatherConditionImage.image = UIImage(named: "cloud.rain.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.rainColor
        temperatureLabel.textColor = UIColor.ElementColorDark.rainColor
        humidityLabel.textColor = UIColor.ElementColorDark.rainColor
        pressureLabel.textColor = UIColor.ElementColorDark.rainColor
        windLabel.textColor = UIColor.ElementColorDark.rainColor
        textField.backgroundColor = UIColor.ElementColorDark.rainColor
        textField.textColor = UIColor.BackgroundColorDark.rainColor
        switchButton.tintColor = UIColor.ElementColorDark.thunderColor
        shareButton.tintColor = UIColor.ElementColorDark.rainColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.rainColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.rainColor
    }
    func setThunderDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.thunderColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.thunderColor
        tempImageLabel.image = UIImage(named: "temp.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        windImageLabel.image = UIImage(named: "wind.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        weatherConditionImage.image = UIImage(named: "cloud.bolt.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.thunderColor
        temperatureLabel.textColor = UIColor.ElementColorDark.thunderColor
        humidityLabel.textColor = UIColor.ElementColorDark.thunderColor
        pressureLabel.textColor = UIColor.ElementColorDark.thunderColor
        windLabel.textColor = UIColor.ElementColorDark.thunderColor
        textField.backgroundColor = UIColor.ElementColorDark.thunderColor
        textField.textColor = UIColor.BackgroundColorDark.thunderColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
        shareButton.tintColor = UIColor.ElementColorDark.thunderColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.thunderColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.bolt")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.thunderColor
    }
    func setFogDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.fogColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.fogColor
        tempImageLabel.image = UIImage(named: "temp.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        windImageLabel.image = UIImage(named: "wind.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        weatherConditionImage.image = UIImage(named: "cloud.fog.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.fogColor
        temperatureLabel.textColor = UIColor.ElementColorDark.fogColor
        humidityLabel.textColor = UIColor.ElementColorDark.fogColor
        pressureLabel.textColor = UIColor.ElementColorDark.fogColor
        windLabel.textColor = UIColor.ElementColorDark.fogColor
        textField.backgroundColor = UIColor.ElementColorDark.fogColor
        textField.textColor = UIColor.BackgroundColorDark.fogColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
        shareButton.tintColor = UIColor.ElementColorDark.fogColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.fogColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.fog")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.fogColor
    }
    func setSnowDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.snowColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.snowColor
        tempImageLabel.image = UIImage(named: "temp.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        windImageLabel.image = UIImage(named: "wind.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        weatherConditionImage.image = UIImage(named: "cloud.snow.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.snowColor
        temperatureLabel.textColor = UIColor.ElementColorDark.snowColor
        humidityLabel.textColor = UIColor.ElementColorDark.snowColor
        pressureLabel.textColor = UIColor.ElementColorDark.snowColor
        windLabel.textColor = UIColor.ElementColorDark.snowColor
        textField.backgroundColor = UIColor.ElementColorDark.snowColor
        textField.textColor = UIColor.BackgroundColorDark.snowColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
        shareButton.tintColor = UIColor.ElementColorDark.snowColor
        
        tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.snowColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.snow")
        tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.snowColor
    }
}

