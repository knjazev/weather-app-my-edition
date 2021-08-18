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

class ViewController: UIViewController, UITextFieldDelegate, UITabBarDelegate {
    
    var array = [WeatherDetail]()
    var jsonName = ""
    
    var testTableView = TableViewController()
    var tabBar = TabBarController()
    
    var arrayOfCityNames: [String] = []
    
//    @IBOutlet weak var textField: UITextField!
    
    private let viewModel = ViewModel()
    
//    @IBOutlet weak var temperatureLabel: UILabel!
//    @IBOutlet weak var humidityLabel: UILabel!
//    @IBOutlet weak var pressureLabel: UILabel!
//
//    @IBOutlet weak var windLabel: UILabel!
//    @IBOutlet weak var weatherConditionImage: UIImageView!
//    @IBOutlet weak var cityLabel: UILabel!
//
//    @IBOutlet weak var switchLabel: UISegmentedControl!
//
//    @IBOutlet weak var tempImageLabel: UIImageView!
//    @IBOutlet weak var humidityImageLabel: UIImageView!
//    @IBOutlet weak var pressureImageLabel: UIImageView!
//    @IBOutlet weak var windImageLabel: UIImageView!
//
//    @IBOutlet weak var getLocationButton: UIButton!
    
    
    let cityLabel = UILabel()
    let textField = UITextField()
    let weatherConditionImage = UIImageView()
    let temperatureLabel = UILabel()
    let humidityLabel = UILabel()
    let pressureLabel = UILabel()
    let windLabel = UILabel()
    
    
//        let switchLabel = UISegmentedControl()
    
    let tempImageLabel = UIImageView()
    let humidityImageLabel = UIImageView()
    let pressureImageLabel = UIImageView()
    let windImageLabel = UIImageView()
    
    let getLocationButton = UIButton()
    
    
    
    
    var animation: Animation!
    var animationView: AnimationView!
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        getLocationButton.addTarget(self, action: #selector(getLocation), for: .touchUpInside)

        initialize()

        textField.delegate = self
        textField.text = viewModel.city
        viewModel.delegatation()
        
        animation = Animation.named(jsonName)
        animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: 150, y: 150, width: 150, height: 150)
        
        
        //        view.addSubview((animationView)!)
        
        
        binding()
     

//        if traitCollection.userInterfaceStyle == .dark {
//            switchLabel.selectedSegmentIndex = 1
//            weatherConditionImage.tintColor = .white
//        }else if (traitCollection.userInterfaceStyle == .light) {
//            switchLabel.selectedSegmentIndex = 0
//            weatherConditionImage.tintColor = .black
//        }else if (traitCollection.userInterfaceStyle == .unspecified) {
//            switchLabel.selectedSegmentIndex = 0
//            weatherConditionImage.tintColor = .black
//        }
        
    }
    
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        switch previousTraitCollection?.userInterfaceStyle {
        case .light:
            weatherConditionImage.tintColor = .white
        case .dark:
            weatherConditionImage.tintColor = .black
        case .unspecified :
            weatherConditionImage.tintColor = .black
        default:
            weatherConditionImage.tintColor = .black
        }
    }
    
    @IBAction func changeMode(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            overrideUserInterfaceStyle = .light
            weatherConditionImage.tintColor = .black
            
        } else if (sender.selectedSegmentIndex == 1) {
//            overrideUserInterfaceStyle = .dark
            weatherConditionImage.tintColor = .white
            
        }
    }
    
    
//    @IBAction func buttonTapped(_ sender: UIButton) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "table") as? TableViewController {
//
//    }
//    }

    @objc func getLocation(_ sender: UIButton) {

        WeatherAPI.trigger = 1
        viewModel.locationManager.requestLocation()
        
        let lat = viewModel.locationManager.location?.coordinate.latitude as! Double
        let lon = viewModel.locationManager.location?.coordinate.longitude as! Double
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
                
                switch currentWeather.list?[0].weather?[0].main?.rawValue {
                
                case "Clear":
                    self?.view.backgroundColor = UIColor.BackgroundColor.sunColor
                    
                    self?.getLocationButton.setImage(UIImage(named: "location.sun.max"), for: UIControl.State.normal)
                    self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.sunColor
                    self?.tempImageLabel.image = UIImage(named: "temp.sun.max")
                    self?.windImageLabel.image = UIImage(named: "wind.sun")
                    self?.humidityImageLabel.image = UIImage(named: "humidity.sun.max")
                    self?.pressureImageLabel.image = UIImage(named: "pressure.sun.max")
                    
                    self?.cityLabel.textColor = UIColor.ElementColor.sunColor
                    self?.temperatureLabel.textColor = UIColor.ElementColor.sunColor
                    self?.humidityLabel.textColor = UIColor.ElementColor.sunColor
                    self?.pressureLabel.textColor = UIColor.ElementColor.sunColor
                    self?.windLabel.textColor = UIColor.ElementColor.sunColor
                    self?.textField.backgroundColor = UIColor.ElementColor.sunColor
                    
                    self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.sunColor
                    self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")
                    self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.sunColor
        
                    
                case "Rain":
                    self?.view.backgroundColor = UIColor.BackgroundColor.rainColor
                    
                    self?.getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: UIControl.State.normal)
                    self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.rainColor
                    self?.tempImageLabel.image = UIImage(named: "temp.cloud.rain")
                    self?.windImageLabel.image = UIImage(named: "wind.cloud.rain")
                    self?.humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
                    self?.pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
                    
                    self?.cityLabel.textColor = UIColor.BackgroundColor.rainColor
                    self?.temperatureLabel.textColor = UIColor.BackgroundColor.rainColor
                    self?.humidityLabel.textColor = UIColor.BackgroundColor.rainColor
                    self?.pressureLabel.textColor = UIColor.BackgroundColor.rainColor
                    self?.windLabel.textColor = UIColor.BackgroundColor.rainColor
                    self?.textField.backgroundColor = UIColor.BackgroundColor.rainColor
                    
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
                    
                    self?.cityLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.temperatureLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.humidityLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.pressureLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.windLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.textField.backgroundColor = UIColor.ElementColor.cloudColor
                    
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
                    
                    self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.fogColor
                    self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.fog")
                    self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.fogColor

                default:
                    self?.view.backgroundColor = UIColor.BackgroundColor.sunColor
                    
                    self?.getLocationButton.setImage(UIImage(named: "location.sun.max"), for: UIControl.State.normal)
                    self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.sunColor
                    self?.tempImageLabel.image = UIImage(named: "temp.sun.max")
                    self?.windImageLabel.image = UIImage(named: "wind.sun")
                    self?.humidityImageLabel.image = UIImage(named: "humidity.sun.max")
                    self?.pressureImageLabel.image = UIImage(named: "pressure.sun.max")
                    
                    self?.cityLabel.textColor = UIColor.ElementColor.sunColor
                    self?.temperatureLabel.textColor = UIColor.ElementColor.sunColor
                    self?.humidityLabel.textColor = UIColor.ElementColor.sunColor
                    self?.pressureLabel.textColor = UIColor.ElementColor.sunColor
                    self?.windLabel.textColor = UIColor.ElementColor.sunColor
                    self?.textField.backgroundColor = UIColor.ElementColor.sunColor
                    
                    self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.sunColor
                    self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")
                    self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.sunColor
                }
                
                self?.cityLabel.text =
                    currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : ""
                
                self?.temperatureLabel.text =
                    currentWeather.list?[0].main?.temp != nil ?
                    "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                    : " "
                
                self?.humidityLabel.text =
                    currentWeather.list?[0].main?.humidity != nil ?
                    "\(Int((currentWeather.list?[0].main?.humidity!)!)) %"
                    : " "
                
                self?.windLabel.text =
                    currentWeather.list?[0].wind?.speed != nil ?
                    "\(Int((currentWeather.list?[0].wind?.speed!)!)) km/h"
                    : " "
                
                self?.pressureLabel.text =
                    currentWeather.list?[0].main?.pressure != nil ?
                    "\(Int((currentWeather.list?[0].main?.pressure!)!)) hPa"
                    : " "
                
                self?.weatherConditionImage.image = UIImage(named:  self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 100) ?? "sun.max")
                
                //                self?.jsonName = self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800) ?? "sun.max"
                
                self?.jsonName = (self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800))!
                
                self?.animationView.play()
          
                
                //                self?.playAnimation()
                
            }
            )
            .store(in: &cancellable)

        textField.text = ""
    }

    func binding() {
        textField.textPublisher
            .assign(to: \.city, on: viewModel)
            .store(in: &cancellable)
        
        viewModel.$currentWeather
            .sink(receiveValue: {[weak self] currentWeather in
                WeatherAPI.trigger = 0
                
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
                    
                    self?.cityLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.temperatureLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.humidityLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.pressureLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.windLabel.textColor = UIColor.ElementColor.cloudColor
                    self?.textField.backgroundColor = UIColor.ElementColor.cloudColor
                    self?.textField.textColor = UIColor.BackgroundColor.cloudColor
                    
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
                    
                    self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.fogColor
                    self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.cloud.fog")
                    self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.fogColor

                default:
                    self?.view.backgroundColor = UIColor.BackgroundColor.sunColor
                    
                    self?.getLocationButton.setImage(UIImage(named: "location.sun.max"), for: UIControl.State.normal)
                    self?.getLocationButton.backgroundColor = UIColor.BackgroundColor.sunColor
                    self?.tempImageLabel.image = UIImage(named: "temp.sun.max")
                    self?.windImageLabel.image = UIImage(named: "wind.sun")
                    self?.humidityImageLabel.image = UIImage(named: "humidity.sun.max")
                    self?.pressureImageLabel.image = UIImage(named: "pressure.sun.max")
                    
                    self?.cityLabel.textColor = UIColor.ElementColor.sunColor
                    self?.temperatureLabel.textColor = UIColor.ElementColor.sunColor
                    self?.humidityLabel.textColor = UIColor.ElementColor.sunColor
                    self?.pressureLabel.textColor = UIColor.ElementColor.sunColor
                    self?.windLabel.textColor = UIColor.ElementColor.sunColor
                    self?.textField.backgroundColor = UIColor.ElementColor.sunColor
                    self?.textField.textColor = UIColor.BackgroundColor.sunColor
                    
                    self?.tabBarController?.tabBar.barTintColor = UIColor.BackgroundColor.sunColor
                    self?.tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.sun.max")
                    self?.tabBarController?.tabBar.tintColor = UIColor.BackgroundColor.sunColor
                }
                
                self?.cityLabel.text =
                    currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : ""
                
                self?.temperatureLabel.text =
                    currentWeather.list?[0].main?.temp != nil ?
                    "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                    : " "
                
                self?.humidityLabel.text =
                    currentWeather.list?[0].main?.humidity != nil ?
                    "\(Int((currentWeather.list?[0].main?.humidity!)!)) %"
                    : " "
                
                self?.windLabel.text =
                    currentWeather.list?[0].wind?.speed != nil ?
                    "\(Int((currentWeather.list?[0].wind?.speed!)!)) km/h"
                    : " "
                
                self?.pressureLabel.text =
                    currentWeather.list?[0].main?.pressure != nil ?
                    "\(Int((currentWeather.list?[0].main?.pressure!)!)) hPa"
                    : " "
                
                self?.weatherConditionImage.image = UIImage(named:  self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 100) ?? "sun.max")
                
                //                self?.jsonName = self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800) ?? "sun.max"
                
                self?.jsonName = (self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800))!
                
                self?.animationView.play()
          
                
                //                self?.playAnimation()
                
            }
            )
            .store(in: &cancellable)
    }

        private func initialize() {

//            tabBarController?.tabBar.barTintColor = backgrondColor
//            tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.\(name)")
//            tabBarController?.tabBar.tintColor = backgrondColor
//
//            view.backgroundColor = backgrondColor

            
            
    //        let switchLabel = UISegmentedControl()

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
//            textField.textColor = backgrondColor
//            textField.backgroundColor = elementColor
            textField.textAlignment = .left
            view.addSubview(textField)
            
            textField.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.right.equalToSuperview().inset(50)
                maker.left.equalToSuperview().inset(10)
                maker.top.equalTo(cityLabel).inset(60)
//                maker.height.equalTo(20)
            }
            
            // location
            
//            getLocationButton.setImage(UIImage(named: "location.\(name)"), for: UIControl.State.normal)
            
//            getLocationButton.backgroundColor = backgrondColor
            view.addSubview(getLocationButton)
            getLocationButton.snp.makeConstraints { maker in
                
                maker.top.equalTo(cityLabel).inset(60)
//                maker.height.equalTo(40)
                maker.right.equalToSuperview().inset(30)
                maker.left.equalTo(textField.snp.right).inset(20)
                maker.centerY.equalTo(textField)
                maker.width.equalTo(getLocationButton.snp.height).multipliedBy(1.0/1.0)
            }
            
            
            //Image Labels
            
//            pressureImageLabel.image = UIImage(named: "pressure.\(name)")
            view.addSubview(pressureImageLabel)
            pressureImageLabel.snp.makeConstraints { maker in
                maker.left.equalToSuperview().inset(30)
                maker.bottomMargin.equalToSuperview().inset(30)
                maker.height.equalTo(45)
                maker.width.equalTo(45)
            }
            
//            humidityImageLabel.image = UIImage(named: "humidity.\(name)")
            view.addSubview(humidityImageLabel)
            humidityImageLabel.snp.makeConstraints { maker in
                maker.left.equalToSuperview().inset(30)
                maker.bottom.equalTo(pressureImageLabel).inset(45)
                maker.height.equalTo(45)
                maker.width.equalTo(45)
            }
            
//            windImageLabel.image = UIImage(named: "wind.\(name)")
            view.addSubview(windImageLabel)
            windImageLabel.snp.makeConstraints { maker in
                maker.left.equalToSuperview().inset(30)
                maker.bottom.equalTo(humidityImageLabel).inset(45)
                maker.height.equalTo(45)
                maker.width.equalTo(45)
            }
            
//            tempImageLabel.image = UIImage(named: "temp.\(name)")
            view.addSubview(tempImageLabel)
            tempImageLabel.snp.makeConstraints { maker in
                maker.left.equalToSuperview().inset(30)
                maker.bottom.equalTo(windImageLabel).inset(45)
                maker.height.equalTo(45)
                maker.width.equalTo(45)
            }
            
            //Labels with data
            
            pressureLabel.text = "1000 hPa"
//            pressureLabel.textColor = elementColor
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
//            humidityLabel.textColor = elementColor
            humidityLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
            view.addSubview(humidityLabel)
            
            humidityLabel.snp.makeConstraints { maker in
                maker.left.equalTo(humidityImageLabel).inset(55)
                maker.right.lessThanOrEqualToSuperview().inset(100)
                maker.centerY.equalTo(humidityImageLabel)
                maker.height.equalTo(humidityImageLabel.snp.height)
            }
            
            windLabel.text = "1000 m/s"
//            windLabel.textColor = elementColor
            windLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
            view.addSubview(windLabel)
            
            windLabel.snp.makeConstraints { maker in
                maker.left.equalTo(windImageLabel).inset(55)
                maker.right.lessThanOrEqualToSuperview().inset(100)
                maker.centerY.equalTo(windImageLabel)
                maker.height.equalTo(windImageLabel.snp.height)
            }
            
            temperatureLabel.text = "1000 ºC"
//            temperatureLabel.textColor = elementColor
            temperatureLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
            view.addSubview(temperatureLabel)
            
            temperatureLabel.snp.makeConstraints { maker in
                maker.left.equalTo(tempImageLabel).inset(55)
                maker.right.lessThanOrEqualToSuperview().inset(100)
                maker.centerY.equalTo(tempImageLabel)
                maker.height.equalTo(tempImageLabel.snp.height)
            }
            
//            weatherConditionImage.image = UIImage(named: "\(name)")
            view.addSubview(weatherConditionImage)
            weatherConditionImage.snp.makeConstraints { maker in
                maker.top.equalTo(textField).inset(60)
                maker.right.equalToSuperview().inset(0)
                maker.left.greaterThanOrEqualTo(0)
                maker.bottom.equalTo(temperatureLabel).inset(30)
                temperatureLabel
                maker.width.equalTo(weatherConditionImage.snp.height).multipliedBy(1.0/1.0)
            }
        }
}

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
}


