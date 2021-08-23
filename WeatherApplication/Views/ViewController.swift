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
import Reachability
import Network

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
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = false
        
        let button = UIBarButtonItem(image: UIImage(named: "forecast.cloud"), style: .done, target: self, action: #selector(getForecast))
        
        setToolbarItems([button], animated: true)
        
        
        NetworkMonitor.shared.startMonitoring()
        
        initialize()
        binding()
        textField.delegate = self
        textField.text = viewModel.city
        
        
        
        getLocationButton.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        // MARK: - Hide Keyboard using gesture
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        checkTheConnection()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tvc" {
            _ = segue.destination as! TableViewController
    
        }
    }
    
    @objc func getForecast(_ sender: UIBarButtonItem) {
        
        let tvc = (self.storyboard?.instantiateViewController(withIdentifier:"tvc") as? TableViewController)
        
//        navigationController?.modalPresentationStyle = .fullScreen
       
        navigationController?.present(tvc!, animated: true)
    
    }
    
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
            print("wowow")
            overrideUserInterfaceStyle = .light
            viewDidLoad()
            self.switchButton.isEnabled = true
            
        case true:
            if traitCollection.userInterfaceStyle == .light && WeatherAPI.getLocationOnView == true {
                print("Light & True: \(WeatherAPI.getLocationOnView)")
                overrideUserInterfaceStyle = .dark
                getLocation(sender)
                switchButton.setImage(UIImage(named: "light.mode"), for: .normal)

            }else if traitCollection.userInterfaceStyle == .dark && WeatherAPI.getLocationOnView == true {
                print("Dark & True: \(WeatherAPI.getLocationOnView)")
                overrideUserInterfaceStyle = .light
                getLocation(sender)
                switchButton.setImage(UIImage(named: "dark.mode"), for: .normal)
 
            }else if traitCollection.userInterfaceStyle == .light && WeatherAPI.getLocationOnView == false {
                print("Light & False: \(WeatherAPI.getLocationOnView)")
                overrideUserInterfaceStyle = .dark
                //                viewDidLoad()
                binding()
                switchButton.setImage(UIImage(named: "light.mode"), for: .normal)
                
            }else {
                print("Dark & False: \(WeatherAPI.getLocationOnView)")
                overrideUserInterfaceStyle = .light
                //                viewDidLoad()
                binding()
                switchButton.setImage(UIImage(named: "dark.mode"), for: .normal)
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
        subcribeAndUpdateUI(weather: viewModel.$currentWeather2, trigrer: 1)
    }
    
    //MARK: Binding
    
    func binding() {
        textField.textPublisher
            .assign(to: \.city, on: viewModel)
            .store(in: &cancellable)
        subcribeAndUpdateUI(weather: viewModel.$currentWeather, trigrer: 0)
        
    }
    
    private func subcribeAndUpdateUI(weather: Published<WeatherDetail>.Publisher, trigrer: Int) {
        weather
            .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] currentWeather in
                WeatherAPI.numberOfRows = currentWeather.list?.count ?? 40
                WeatherAPI.trigger = trigrer
                self?.checkTheConnection()
                
                if self?.traitCollection.userInterfaceStyle == .light {
                    
                    //MARK: Light mode
                    
                    switch currentWeather.list?[0].weather?[0].main?.rawValue {
                    
                    case "Clear":
                        self?.setClearLightState()
                    case "Rain":
                        self?.setRainLightState()
                    case "Clouds":
                        self?.setCloudsLightState()
                    case "Thunderstorm":
                        self?.setThunderLightState()
                    case "Snow":
                        self?.setSnowLightState()
                    case "Fog", "Tornado", "Haze", "Dust", "Sand", "Ash", "Squall" :
                        self?.setFogLightState()
                    default:
                        self?.setRainLightState()
                    }
                    
                    self?.weatherConditionImage.image = UIImage(named:  self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 100) ?? "sun.max")
                    
                    // MARK: Dark mode
                    
                } else if self?.traitCollection.userInterfaceStyle == .dark {
                    
                    switch currentWeather.list?[0].weather?[0].main?.rawValue {
                    
                    case "Clear":
                        self?.setClearDarkState()
                    case "Rain":
                        self?.setRainDarkState()
                    case "Clouds":
                        self?.setCloudsDarkState()
                    case "Thunderstorm":
                        self?.setThunderDarkState()
                    case "Snow":
                        self?.setSnowDarkState()
                    case "Fog", "Tornado", "Haze", "Dust", "Sand", "Ash", "Squall" :
                        self?.setFogDarkState()
                    default:
                        self?.setRainDarkState()
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
        //        switchButton.backgroundColor = .yellow
        switchButton.frame.size = CGSize(width: 60, height: 60)
        
        if !switchButton.isSelected && traitCollection.userInterfaceStyle == .light {
            switchButton.setImage(UIImage(named: "dark.mode"), for: .normal)
            
        }else if !switchButton.isSelected && traitCollection.userInterfaceStyle == .dark {
            switchButton.setImage(UIImage(named: "light.mode"), for: .normal)
        }
        
        switchButton.snp.makeConstraints { maker in
            maker.bottomMargin.equalToSuperview().inset(30)
            maker.height.equalTo(60)
            maker.width.equalTo(60)
            maker.right.equalToSuperview().inset(10)
        }
        
        view.addSubview(animationView)
        //        animationView.backgroundColor = .blue
        animationView.loopMode = .loop
        animationView.play()
        animationView.snp.makeConstraints { maker in
            maker.width.equalTo(80)
            maker.width.equalTo(animationView.snp.height).multipliedBy(1.0/1.0)
            maker.right.equalToSuperview().inset(0)
            maker.bottomMargin.equalToSuperview().inset(80)
        }
        
        view.addSubview(shareButton)
        //        shareButton.backgroundColor = .red
        shareButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        shareButton.snp.makeConstraints { maker in
            maker.width.equalTo(60)
            maker.width.equalTo(shareButton.snp.height).multipliedBy(1.0/1.0)
            maker.center.equalTo(animationView.snp.center)
            maker.bottomMargin.equalToSuperview().inset(80)
        }
        
        switchButton.layer.zPosition = 12
        animationView.layer.zPosition = 10
        shareButton.layer.zPosition = 11
    }
    
    func checkTheConnection() {
        if NetworkMonitor.shared.isReachable {
        }else {
            let ac = UIAlertController(title: "No internet connection", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            
            ac.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                if let bundleIdentifier = Bundle.main.bundleIdentifier, let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
                    if UIApplication.shared.canOpenURL(appSettings) {
                        UIApplication.shared.open(appSettings)
                    }
                }
            }))
            
            present(ac, animated: true)
        }
    }
}


