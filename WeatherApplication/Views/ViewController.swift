//
//  ViewController.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//

import UIKit
import Combine
import CoreLocation
import Lottie
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate, UITabBarDelegate, UIImagePickerControllerDelegate {
    
    private let viewModel = ViewModel()
    
    let cityLabel = UILabel()
    let textField = UITextField()
    let weatherConditionImage = UIImageView()
    let temperatureLabel = UILabel()
    let humidityLabel = UILabel()
    let pressureLabel = UILabel()
    let windLabel = UILabel()
    let switchButton = UIButton(type: .custom)
    let tempImageLabel = UIImageView()
    let humidityImageLabel = UIImageView()
    let pressureImageLabel = UIImageView()
    let windImageLabel = UIImageView()
    let getLocationButton = UIButton()
    let shareButton = UIButton()
    let animationView = AnimationView(name: "tap2")
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        binding()
        
        textField.delegate = self
        textField.text = viewModel.city
        
        getLocationButton.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(changeMode), for: .allEvents)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        // MARK: - Hide Keyboard using gesture
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//    }
    
    // MARK: - Hide Keyboard using return keyboard button
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: Take a screenshot for share with friends
    
    @objc func share(_ sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let vc = UIActivityViewController(activityItems: [image as Any, "From TheWeather app"], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    
    //MARK: Change mode
    
    @objc func changeMode(_ sender: UIButton) {
        switch sender.isEnabled {
        case false:
            overrideUserInterfaceStyle = .light
            viewDidLoad()
            self.switchButton.isEnabled = true
            
        case true:
            if traitCollection.userInterfaceStyle == .light && WeatherAPI.getLocationOnView == true {
                overrideUserInterfaceStyle = .dark
                getLocation(sender)
                switchButton.setImage(UIImage(systemName: "sun.max"), for: .normal)

            }else if traitCollection.userInterfaceStyle == .dark && WeatherAPI.getLocationOnView == true {
                overrideUserInterfaceStyle = .light
                getLocation(sender)
                switchButton.setImage(UIImage(systemName: "moon.fill"), for: .normal)
                
            }else if traitCollection.userInterfaceStyle == .light {
                overrideUserInterfaceStyle = .dark
                viewDidLoad()
                switchButton.setImage(UIImage(systemName: "sun.max"), for: .normal)
                
            }else {
                overrideUserInterfaceStyle = .light
                viewDidLoad()
                switchButton.setImage(UIImage(systemName: "moon.fill"), for: .normal)
            }
            self.switchButton.isEnabled = true
        }
    }
    
    //MARK: Get Location
    
    
    @objc func getLocation(_ sender: UIButton) {
        WeatherAPI.trigger = 1
        WeatherAPI.getLocationOnView = true
        viewModel.delegatation()
        
        let lat = Double(viewModel.locationManager.location?.coordinate.latitude ?? 0.0)
        let lon = Double(viewModel.locationManager.location?.coordinate.longitude ?? 0.0)
        let publisher = [lat,lon].publisher
        let publisher2 = [lon,lat].publisher
        
        publisher
            .assign(to: \.coordinates[1], on: viewModel)
            .store(in: &cancellable)
        publisher2
            .assign(to: \.coordinates[0], on: viewModel)
            .store(in: &cancellable)
        
        viewModel.$currentWeather2
            .sink(receiveValue: {[weak self] currentWeather in
                WeatherAPI.numberOfRows = currentWeather.list?.count ?? 5
                if self?.traitCollection.userInterfaceStyle == .light {
                    
                    //MARK: Light mode
                    
                    switch currentWeather.list?[0].weather?[0].main?.rawValue {
                    
                    case "Clear":
                        self?.view.backgroundColor = UIColor.BackgroundColor.sunColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.sun.max"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.sunColor
                        
                        self?.tempImageLabel.image = UIImage(named: "temp.sun.max")
                        self?.windImageLabel.image = UIImage(named: "wind.sun.max")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.sun.max")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.sun.max")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.sunColor
                        self?.temperatureLabel.textColor = UIColor.ElementColor.sunColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.sunColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.sunColor
                        self?.windLabel.textColor = UIColor.ElementColor.sunColor
                        self?.textField.backgroundColor = UIColor.ElementColor.sunColor
                        self?.switchButton.tintColor = UIColor.ElementColor.sunColor
                        self?.shareButton.tintColor = UIColor.ElementColor.sunColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.sunColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.sunColor
                        self?.textField.textColor = UIColor.BackgroundColor.sunColor
                        
                        
                    case "Rain":
                        self?.view.backgroundColor = UIColor.BackgroundColor.rainColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.rainColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.rainColor
                        self?.temperatureLabel.textColor = UIColor.ElementColor.rainColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.rainColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.rainColor
                        self?.windLabel.textColor = UIColor.ElementColor.rainColor
                        self?.textField.backgroundColor = UIColor.ElementColor.rainColor
                        self?.textField.textColor = UIColor.BackgroundColor.rainColor
                        self?.switchButton.tintColor = UIColor.ElementColor.rainColor
                        self?.shareButton.tintColor = UIColor.ElementColor.rainColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.rainColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.rainColor
                        
                        
                    case "Clouds":
                        self?.view.backgroundColor = UIColor.BackgroundColor.cloudColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.cloudColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud")
                        self?.weatherConditionImage.image = UIImage(named: "cloud")
                        
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.temperatureLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.windLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.textField.backgroundColor = UIColor.ElementColor.cloudColor
                        self?.textField.textColor = UIColor.BackgroundColor.cloudColor
                        self?.switchButton.tintColor = UIColor.ElementColor.cloudColor
                        self?.shareButton.tintColor = UIColor.ElementColor.cloudColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.cloudColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.cloudColor
                        
                    case "Thunderstorm":
                        self?.view.backgroundColor = UIColor.BackgroundColor.thunderColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.bolt"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.thunderColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.bolt")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.bolt")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.thunderColor
                        
                        self?.temperatureLabel.textColor = UIColor.ElementColor.thunderColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.thunderColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.thunderColor
                        self?.windLabel.textColor = UIColor.ElementColor.thunderColor
                        self?.textField.backgroundColor = UIColor.ElementColor.thunderColor
                        self?.textField.textColor = UIColor.BackgroundColor.thunderColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColor.thunderColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.thunderColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.bolt")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.thunderColor
                        
                    case "Snow":
                        self?.view.backgroundColor = UIColor.BackgroundColor.snowColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.snow"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.snowColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.snow")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.snow")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.snowColor
                        
                        self?.temperatureLabel.textColor = UIColor.ElementColor.snowColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.snowColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.snowColor
                        self?.windLabel.textColor = UIColor.ElementColor.snowColor
                        self?.textField.backgroundColor = UIColor.ElementColor.snowColor
                        self?.textField.textColor = UIColor.BackgroundColor.snowColor
                        self?.switchButton.tintColor = UIColor.ElementColor.snowColor
                        self?.shareButton.tintColor = UIColor.ElementColor.snowColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.snowColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.snow")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.snowColor
                        
                    case "Fog", "Tornado", "Haze", "Dust", "Fog",  "Sand", "Dust", "Ash", "Squall" :
                        
                        self?.view.backgroundColor = UIColor.BackgroundColor.fogColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.fog"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.fogColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.fog")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.fog")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.fogColor
                        
                        self?.temperatureLabel.textColor = UIColor.ElementColor.fogColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.fogColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.fogColor
                        self?.windLabel.textColor = UIColor.ElementColor.fogColor
                        self?.textField.backgroundColor = UIColor.ElementColor.fogColor
                        self?.textField.textColor = UIColor.BackgroundColor.fogColor
                        self?.switchButton.tintColor = UIColor.ElementColor.fogColor
                        self?.shareButton.tintColor = UIColor.ElementColor.fogColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.fogColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.fog")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.fogColor
                        
                    default:
                        self?.view.backgroundColor = UIColor.BackgroundColor.rainColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.rainColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.rainColor
                        self?.temperatureLabel.textColor = UIColor.ElementColor.rainColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.rainColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.rainColor
                        self?.windLabel.textColor = UIColor.ElementColor.rainColor
                        self?.textField.backgroundColor = UIColor.ElementColor.rainColor
                        self?.textField.textColor = UIColor.BackgroundColor.rainColor
                        self?.switchButton.tintColor = UIColor.ElementColor.rainColor
                        self?.shareButton.tintColor = UIColor.ElementColor.rainColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.rainColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.rainColor
                        
                    }
                    
                    self?.weatherConditionImage.image = UIImage(named:  self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 100) ?? "sun.max")
                    
                    // MARK: Dark mode
                    
                } else if self?.traitCollection.userInterfaceStyle == .dark {
                    
                    switch currentWeather.list?[0].weather?[0].main?.rawValue {
                    
                    case "Clear":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.sunColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.sunColor
                        self?.tempImageLabel.image = UIImage(named: "temp.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.windImageLabel.image = UIImage(named: "wind.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.weatherConditionImage.image = UIImage(named: "sun.max.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.sunColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.sunColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.sunColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.sunColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.sunColor
                        
                        
                    case "Rain":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.rainColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.rainColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.rain.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.rainColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.rainColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.rainColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.rainColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.rainColor
                        
                        
                    case "Clouds":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.cloudColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.cloudColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.cloudColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.cloudColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.cloudColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.cloudColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.cloudColor
                        
                    case "Thunderstorm":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.thunderColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.thunderColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.bolt.dark")
                        
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.thunderColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.thunderColor
                        self?.cityLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.thunderColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.thunderColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.bolt")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.thunderColor
                        
                    case "Snow":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.snowColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.snowColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.snow.dark")
                        
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.snowColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.snowColor
                        self?.cityLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.snowColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.snowColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.snow")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.snowColor
                        
                    case "Fog", "Tornado", "Haze", "Dust", "Fog",  "Sand", "Dust", "Ash", "Squall" :
                        
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.fogColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.fogColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.fog.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.fogColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.fogColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.thunderColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.fogColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.fog")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.fogColor
                        
                    default:
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.rainColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.rainColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.rainColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.rainColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.rainColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.rainColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.rainColor
                    }
                    
                    self?.weatherConditionImage.image = UIImage(named:  (self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 100) ?? "sun.max") + ".dark")
                }
                
                self?.cityLabel.text =
                    currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : "Type city name"
                
                self?.temperatureLabel.text =
                    currentWeather.list?[0].main?.temp != nil ?
                    "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                    : "--------"
                
                self?.humidityLabel.text =
                    currentWeather.list?[0].main?.humidity != nil ?
                    "\(Int((currentWeather.list?[0].main?.humidity!)!)) %"
                    : "--------"
                
                self?.windLabel.text =
                    currentWeather.list?[0].wind?.speed != nil ?
                    "\(Int((currentWeather.list?[0].wind?.speed!)!)) km/h"
                    : "--------"
                
                self?.pressureLabel.text =
                    currentWeather.list?[0].main?.pressure != nil ?
                    "\(Int((currentWeather.list?[0].main?.pressure!)!)) hPa"
                    : "--------"   
            }
            )
            .store(in: &cancellable)
        textField.text = ""
    }
    
    //MARK: Binding
    
    func binding() {
        textField.textPublisher
            .assign(to: \.city, on: viewModel)
            .store(in: &cancellable)
        
        viewModel.$currentWeather
            .sink(receiveValue: {[weak self] currentWeather in
                WeatherAPI.numberOfRows = currentWeather.list?.count ?? 5
                
                //MARK: Light mode
                if self?.traitCollection.userInterfaceStyle == .light {

                    switch currentWeather.list?[0].weather?[0].main?.rawValue {
                    
                    case "Clear":
                        self?.view.backgroundColor = UIColor.BackgroundColor.sunColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.sun.max"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.sunColor
                        
                        self?.tempImageLabel.image = UIImage(named: "temp.sun.max")
                        self?.windImageLabel.image = UIImage(named: "wind.sun.max")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.sun.max")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.sun.max")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.sunColor
                        self?.temperatureLabel.textColor = UIColor.ElementColor.sunColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.sunColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.sunColor
                        self?.windLabel.textColor = UIColor.ElementColor.sunColor
                        self?.textField.backgroundColor = UIColor.ElementColor.sunColor
                        self?.switchButton.tintColor = UIColor.ElementColor.sunColor
                        self?.shareButton.tintColor = UIColor.ElementColor.sunColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.sunColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.sunColor
                        self?.textField.textColor = UIColor.BackgroundColor.sunColor
                        
                        
                    case "Rain":
                        self?.view.backgroundColor = UIColor.BackgroundColor.rainColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.rainColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.rainColor
                        self?.temperatureLabel.textColor = UIColor.ElementColor.rainColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.rainColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.rainColor
                        self?.windLabel.textColor = UIColor.ElementColor.rainColor
                        self?.textField.backgroundColor = UIColor.ElementColor.rainColor
                        self?.textField.textColor = UIColor.BackgroundColor.rainColor
                        self?.switchButton.tintColor = UIColor.ElementColor.rainColor
                        self?.shareButton.tintColor = UIColor.ElementColor.rainColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.rainColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.rainColor
                        
                        
                    case "Clouds":
                        self?.view.backgroundColor = UIColor.BackgroundColor.cloudColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.cloudColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud")
                        self?.weatherConditionImage.image = UIImage(named: "cloud")
                        
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.temperatureLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.windLabel.textColor = UIColor.ElementColor.cloudColor
                        self?.textField.backgroundColor = UIColor.ElementColor.cloudColor
                        self?.textField.textColor = UIColor.BackgroundColor.cloudColor
                        self?.switchButton.tintColor = UIColor.ElementColor.cloudColor
                        self?.shareButton.tintColor = UIColor.ElementColor.cloudColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.cloudColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.cloudColor
                        
                    case "Thunderstorm":
                        self?.view.backgroundColor = UIColor.BackgroundColor.thunderColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.bolt"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.thunderColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.bolt")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.bolt")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.thunderColor
                        
                        self?.temperatureLabel.textColor = UIColor.ElementColor.thunderColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.thunderColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.thunderColor
                        self?.windLabel.textColor = UIColor.ElementColor.thunderColor
                        self?.textField.backgroundColor = UIColor.ElementColor.thunderColor
                        self?.textField.textColor = UIColor.BackgroundColor.thunderColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColor.thunderColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.thunderColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.bolt")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.thunderColor
                        
                    case "Snow":
                        self?.view.backgroundColor = UIColor.BackgroundColor.snowColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.snow"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.snowColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.snow")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.snow")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.snowColor
                        
                        self?.temperatureLabel.textColor = UIColor.ElementColor.snowColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.snowColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.snowColor
                        self?.windLabel.textColor = UIColor.ElementColor.snowColor
                        self?.textField.backgroundColor = UIColor.ElementColor.snowColor
                        self?.textField.textColor = UIColor.BackgroundColor.snowColor
                        self?.switchButton.tintColor = UIColor.ElementColor.snowColor
                        self?.shareButton.tintColor = UIColor.ElementColor.snowColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.snowColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.snow")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.snowColor
                        
                    case "Fog", "Tornado", "Haze", "Dust", "Fog",  "Sand", "Dust", "Ash", "Squall" :
                        
                        self?.view.backgroundColor = UIColor.BackgroundColor.fogColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.fog"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.fogColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.fog")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.fog")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.fogColor
                        
                        self?.temperatureLabel.textColor = UIColor.ElementColor.fogColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.fogColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.fogColor
                        self?.windLabel.textColor = UIColor.ElementColor.fogColor
                        self?.textField.backgroundColor = UIColor.ElementColor.fogColor
                        self?.textField.textColor = UIColor.BackgroundColor.fogColor
                        self?.switchButton.tintColor = UIColor.ElementColor.fogColor
                        self?.shareButton.tintColor = UIColor.ElementColor.fogColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.fogColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.fog")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.fogColor
                        
                    default:
                        self?.view.backgroundColor = UIColor.BackgroundColor.rainColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.rainColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
                        
                        self?.cityLabel.textColor = UIColor.ElementColor.rainColor
                        self?.temperatureLabel.textColor = UIColor.ElementColor.rainColor
                        self?.humidityLabel.textColor = UIColor.ElementColor.rainColor
                        self?.pressureLabel.textColor = UIColor.ElementColor.rainColor
                        self?.windLabel.textColor = UIColor.ElementColor.rainColor
                        self?.textField.backgroundColor = UIColor.ElementColor.rainColor
                        self?.textField.textColor = UIColor.BackgroundColor.rainColor
                        self?.switchButton.tintColor = UIColor.ElementColor.rainColor
                        self?.shareButton.tintColor = UIColor.ElementColor.rainColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.rainColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.rainColor
                        
                    }
                    
                    self?.weatherConditionImage.image = UIImage(named:  self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 100) ?? "sun.max")
                    
                    // MARK: Dark mode
                    
                } else if self?.traitCollection.userInterfaceStyle == .dark {
                    
                    switch currentWeather.list?[0].weather?[0].main?.rawValue {
                    
                    case "Clear":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.sunColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.sunColor
                        self?.tempImageLabel.image = UIImage(named: "temp.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.windImageLabel.image = UIImage(named: "wind.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.weatherConditionImage.image = UIImage(named: "sun.max.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.sunColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.sunColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.sunColor
                        self?.switchButton.tintColor = UIColor.ElementColorDark.sunColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.sunColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.sunColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.sunColor
                        
                        
                    case "Rain":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.rainColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.rainColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.rain.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.rainColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.rainColor
                        self?.switchButton.tintColor = UIColor.ElementColorDark.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.rainColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.rainColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.rainColor
                        
                        
                    case "Clouds":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.cloudColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.cloudColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.cloudColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.cloudColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.cloudColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.cloudColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.cloudColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.cloudColor
                        
                    case "Thunderstorm":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.thunderColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.thunderColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.bolt.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.thunderColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.thunderColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.thunderColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.thunderColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.thunderColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.bolt")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.thunderColor
                        
                    case "Snow":
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.snowColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.snowColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.snow.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.snowColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.snowColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.snowColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.snowColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.snowColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.snow")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.snowColor
                        
                    case "Fog", "Tornado", "Haze", "Dust", "Fog",  "Sand", "Dust", "Ash", "Squall" :
                        
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.fogColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.fogColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
                        self?.weatherConditionImage.image = UIImage(named: "cloud.fog.dark")
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.fogColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.fogColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.fogColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.fogColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.fogColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.fog")
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.fogColor
                        
                    default:
                        self?.view.backgroundColor = UIColor.BackgroundColorDark.rainColor
                        
                        self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor), for: UIControl.State.normal)
                        self?.getLocationButton.backgroundColor = UIColor.BackgroundColorDark.rainColor
                        self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        
                        self?.cityLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.temperatureLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.humidityLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.pressureLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.windLabel.textColor = UIColor.ElementColorDark.rainColor
                        self?.textField.backgroundColor = UIColor.ElementColorDark.rainColor
                        self?.textField.textColor = UIColor.BackgroundColorDark.rainColor
                        self?.switchButton.tintColor = UIColor.ElementColor.thunderColor
                        self?.shareButton.tintColor = UIColor.ElementColorDark.rainColor
                        
                        self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColorDark.rainColor
                        self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
                        self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColorDark.rainColor
                    }
                    
                    self?.weatherConditionImage.image = UIImage(named:  (self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 100) ?? "sun.max") + ".dark" )
                }
                
                self?.cityLabel.text =
                    currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : "Type city name"
                
                self?.temperatureLabel.text =
                    currentWeather.list?[0].main?.temp != nil ?
                    "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                    : "--------"
                
                self?.humidityLabel.text =
                    currentWeather.list?[0].main?.humidity != nil ?
                    "\(Int((currentWeather.list?[0].main?.humidity!)!)) %"
                    : "--------"
                
                self?.windLabel.text =
                    currentWeather.list?[0].wind?.speed != nil ?
                    "\(Int((currentWeather.list?[0].wind?.speed!)!)) km/h"
                    : "--------"
                
                self?.pressureLabel.text =
                    currentWeather.list?[0].main?.pressure != nil ?
                    "\(Int((currentWeather.list?[0].main?.pressure!)!)) hPa"
                    : "--------"
            }
            )
            .store(in: &cancellable)
    }
    
    //MARK: Autolayout
    
    private func initialize() {
        
        //City name
        
        cityLabel.text = "Riga"
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.font = UIFont(name: "WhoopAss", size: 60)
        view.addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.top.greaterThanOrEqualToSuperview().inset(60)
            maker.rightMargin.lessThanOrEqualToSuperview().inset(100)
        }
        
        //Textfield
        
        textField.text = "Minsk"
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont(name: "Montserrat-Thin", size: 30)
        textField.textAlignment = .left
        view.addSubview(textField)
        
        textField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.right.equalToSuperview().inset(50)
            maker.left.equalToSuperview().inset(10)
            maker.top.equalTo(cityLabel).inset(60)
        }
        
        view.addSubview(getLocationButton)
        getLocationButton.snp.makeConstraints { maker in
            maker.top.equalTo(cityLabel).inset(60)
            maker.right.equalToSuperview().inset(30)
            maker.left.equalTo(textField.snp.right).inset(20)
            maker.centerY.equalTo(textField)
            maker.width.equalTo(getLocationButton.snp.height).multipliedBy(1.0/1.0)
        }
        
        
        //Image Labels
        
        view.addSubview(pressureImageLabel)
        pressureImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(30)
            maker.bottomMargin.equalToSuperview().inset(30)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        view.addSubview(humidityImageLabel)
        humidityImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(30)
            maker.bottom.equalTo(pressureImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        view.addSubview(windImageLabel)
        windImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(30)
            maker.bottom.equalTo(humidityImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        view.addSubview(tempImageLabel)
        tempImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(30)
            maker.bottom.equalTo(windImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        //Labels with data
        
        pressureLabel.text = "1000 hPa"
        pressureLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        view.addSubview(pressureLabel)
        
        pressureLabel.snp.makeConstraints { maker in
            maker.left.equalTo(pressureImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(pressureImageLabel)
            maker.height.equalTo(pressureImageLabel.snp.height)
            maker.bottomMargin.equalToSuperview().inset(30)
        }
        
        humidityLabel.text = "1000 %"
        humidityLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        view.addSubview(humidityLabel)
        
        humidityLabel.snp.makeConstraints { maker in
            maker.left.equalTo(humidityImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(humidityImageLabel)
            maker.height.equalTo(humidityImageLabel.snp.height)
        }
        
        windLabel.text = "1000 m/s"
        windLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        view.addSubview(windLabel)
        
        windLabel.snp.makeConstraints { maker in
            maker.left.equalTo(windImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(windImageLabel)
            maker.height.equalTo(windImageLabel.snp.height)
        }
        
        temperatureLabel.text = "1000 ºC"
        temperatureLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        view.addSubview(temperatureLabel)
        
        temperatureLabel.snp.makeConstraints { maker in
            maker.left.equalTo(tempImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(tempImageLabel)
            maker.height.equalTo(tempImageLabel.snp.height)
        }
        
        view.addSubview(weatherConditionImage)
        weatherConditionImage.snp.makeConstraints { maker in
            maker.top.equalTo(textField).inset(60)
            maker.right.equalToSuperview().inset(0)
            maker.left.greaterThanOrEqualTo(0)
            maker.bottom.equalTo(temperatureLabel).inset(30)
            maker.width.equalTo(weatherConditionImage.snp.height).multipliedBy(1.0/1.0)
        }
        
        view.addSubview(switchButton)
        switchButton.frame.size = CGSize(width: 60, height: 60)
        
        if !switchButton.isSelected && traitCollection.userInterfaceStyle == .light {
            switchButton.setImage(UIImage(systemName: "moon.fill"), for: .normal)
            //                switchButton.tintColor = .white
            
        }else if !switchButton.isSelected && traitCollection.userInterfaceStyle == .dark {
            switchButton.setImage(UIImage(systemName: "sun.max"), for: .normal)
            //                switchButton.tintColor = .yellow
        }
        
        switchButton.snp.makeConstraints { maker in
            maker.bottomMargin.equalToSuperview().inset(35)
            maker.height.equalTo(50)
            maker.width.equalTo(50)
            maker.right.equalToSuperview().inset(10)
        }
        
        
        
        view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()
        animationView.snp.makeConstraints { maker in
            maker.width.equalTo(80)
            maker.width.equalTo(animationView.snp.height).multipliedBy(1.0/1.0)
            maker.right.equalToSuperview().inset(-5)
            maker.bottomMargin.equalToSuperview().inset(60)
        }
        
        view.addSubview(shareButton)
        shareButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        shareButton.snp.makeConstraints { maker in
            maker.width.equalTo(30)
            maker.width.equalTo(shareButton.snp.height).multipliedBy(1.0/1.0)
            maker.center.equalTo(animationView.snp.center)
            maker.bottomMargin.equalToSuperview().inset(80)
        }
        
        switchButton.layer.zPosition = 11
        animationView.layer.zPosition = 10
        shareButton.layer.zPosition = 11
    }
}


//extension UITextField {
//    var textPublisher: AnyPublisher<String, Never> {
//        NotificationCenter.default
//            .publisher(for: UITextField.textDidChangeNotification, object: self)
//            .compactMap { $0.object as? UITextField }
//            .map { $0.text ?? "" }
//            .eraseToAnyPublisher()
//    }
//}


// With errors
extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}

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
