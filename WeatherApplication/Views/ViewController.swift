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
    let forecastButton = UIBarButtonItem()
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = false
    }
    
    // MARK: - Hide Keyboard using return keyboard button
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: Get Forecast of current location
    
    @objc func getForecast(_ sender: UIBarButtonItem) {
        let tvc = (self.storyboard?.instantiateViewController(withIdentifier: "tvc") as? TableViewController)
        navigationController?.show(tvc!, sender: self)
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
    
    //MARK: Change screen mode
    
    @objc func changeMode(_ sender: UIButton) {
        switch sender.isEnabled {
        case false:
            print("wowow")
            overrideUserInterfaceStyle = .light
            StaticContext.isLightMode = true
            viewDidLoad()
            self.switchButton.isEnabled = true
            
        case true:
            if traitCollection.userInterfaceStyle == .light && StaticContext.getLocationOnView == true {
                print("Light & True: \(StaticContext.getLocationOnView)")
                overrideUserInterfaceStyle = .dark
                StaticContext.isLightMode = false
                getLocation(sender)
            }else if traitCollection.userInterfaceStyle == .dark && StaticContext.getLocationOnView == true {
                print("Dark & True: \(StaticContext.getLocationOnView)")
                overrideUserInterfaceStyle = .light
                StaticContext.isLightMode = true
                getLocation(sender)
            }else if traitCollection.userInterfaceStyle == .light && StaticContext.getLocationOnView == false {
                print("Light & False: \(StaticContext.getLocationOnView)")
                overrideUserInterfaceStyle = .dark
                StaticContext.isLightMode = false
                binding()
            }else {
                print("Dark & False: \(StaticContext.getLocationOnView)")
                overrideUserInterfaceStyle = .light
                StaticContext.isLightMode = true
                binding()
            }
            self.switchButton.isEnabled = true
        }
    }

    //MARK: Get current location
    
    @objc func getLocation(_ sender: UIButton) {
        
        StaticContext.shared.addLoader(view: self)
        
        StaticContext.trigger = 1
        StaticContext.getLocationOnView = true
        self.viewModel.delegatation()
        
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
        subcribeAndUpdateUI(weather: viewModel.$currentWeather2, trigrer: 1, screenMode: true)
        
        
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK: Binding
    
    func binding() {
        StaticContext.shared.addLoader(view: self)
        
        textField.textPublisher
            .assign(to: \.city, on: viewModel)
            .store(in: &cancellable)
        subcribeAndUpdateUI(weather: viewModel.$currentWeather, trigrer: 0, screenMode: false)
        
        dismiss(animated: false, completion: nil)
    }
    
    private func subcribeAndUpdateUI(weather: Published<WeatherDetail>.Publisher, trigrer: Int, screenMode: Bool) {
        weather
            .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] currentWeather in
//                StaticContext.numberOfRows = currentWeather.list?.count ?? 40
                StaticContext.trigger = trigrer
                StaticContext.getLocationOnView = screenMode
                self?.checkTheConnection()
                
                // table view
                
                for item in currentWeather.list ?? [] {
                    StaticContext.objectsArray.append(Objects(sectionName: item.dtTxt?.components(separatedBy: " ")[0] != nil ? "\((item.dtTxt!.components(separatedBy: " ")[0]))" : "", sectionObjects: []))
                }
                
                StaticContext.sectionArray =  StaticContext.objectsArray.uniqued()
                var counter = 0
                for item in currentWeather.list ?? [] {
                    
                    if (item.dtTxt?.components(separatedBy: " ")[0] != nil ? "\((item.dtTxt!.components(separatedBy: " ")[0]))" : "") ==
                        StaticContext.sectionArray[counter].sectionName {
                        
                        print("API:\(item.dtTxt!)")
                        print("___________")
                        print("Section: \(StaticContext.sectionArray[counter].sectionName)")
                        StaticContext.sectionArray[counter].sectionObjects.append("\(item.dtTxt?.components(separatedBy: " ")[1].dropLast(3) != nil ? "\((item.dtTxt!.components(separatedBy: " ")[1].dropLast(3)))" : "")  | \(item.main?.temp != nil ? "\(Int((item.main?.temp!)!)) ºC" : "")")
                        
                    }else {
                        counter = counter + 1
                        StaticContext.sectionArray[counter].sectionObjects.append("\(item.dtTxt?.components(separatedBy: " ")[1].dropLast(3) != nil ? "\((item.dtTxt!.components(separatedBy: " ")[1].dropLast(3)))" : "")  | \(item.main?.temp != nil ? "\(Int((item.main?.temp!)!)) ºC" : "")")
                    }
                }
                
                
                if self?.traitCollection.userInterfaceStyle == .light {
                    
                    //MARK: Light mode
                    
                    switch currentWeather.list?[0].sys?.pod {
                    case .d:
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
                        
                    case .n:
                        switch currentWeather.list?[0].weather?[0].main?.rawValue {
                        
                        case "Clear":
                            self?.setClearLightStateNight()
                        case "Rain":
                            self?.setRainLightStateNight()
                        case "Clouds":
                            self?.setCloudsLightStateNight()
                        case "Thunderstorm":
                            self?.setThunderLightStateNight()
                        case "Snow":
                            self?.setSnowLightStateNight()
                        case "Fog", "Tornado", "Haze", "Dust", "Sand", "Ash", "Squall" :
                            self?.setFogLightStateNight()
                        default:
                            self?.setRainLightStateNight()
                        }

                    default:
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
                    }

                    // MARK: Dark mode
                    
                } else if self?.traitCollection.userInterfaceStyle == .dark {

                    switch currentWeather.list?[0].sys?.pod {
                    case .d:
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
                            self?.setFogLightState()
                        default:
                            self?.setRainDarkState()
                        }
                        
                    case .n:
                        switch currentWeather.list?[0].weather?[0].main?.rawValue {
                        
                        case "Clear":
                            self?.setClearDarkStateNight()
                        case "Rain":
                            self?.setRainDarkStateNight()
                        case "Clouds":
                            self?.setCloudsDarkStateNight()
                        case "Thunderstorm":
                            self?.setThunderDarkStateNight()
                        case "Snow":
                            self?.setSnowDarkStateNight()
                        case "Fog", "Tornado", "Haze", "Dust", "Sand", "Ash", "Squall" :
                            self?.setFogDarkStateNight()
                        default:
                            self?.setRainDarkStateNight()
                        }
                        
                    default:
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
                            self?.setFogLightState()
                        default:
                            self?.setRainDarkState()
                        }
                    }
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
            maker.left.equalToSuperview().inset(10)
            maker.bottomMargin.equalToSuperview().inset(30)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        view.addSubview(humidityImageLabel)
        humidityImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.bottom.equalTo(pressureImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        view.addSubview(windImageLabel)
        windImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.bottom.equalTo(humidityImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        view.addSubview(tempImageLabel)
        tempImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.bottom.equalTo(windImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        
        //Light mode
        
        view.addSubview(switchButton)
        //        switchButton.backgroundColor = .yellow
//        switchButton.frame.size = CGSize(width: 60, height: 60)
        
        if !switchButton.isSelected && traitCollection.userInterfaceStyle == .light {
            switchButton.setImage(UIImage(named: "moon.cloud.rain"), for: .normal)
            
        }else if !switchButton.isSelected && traitCollection.userInterfaceStyle == .dark {
            switchButton.setImage(UIImage(named: "sun.sun"), for: .normal)
        }
        
        switchButton.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(10)
            maker.bottomMargin.equalToSuperview().inset(30)
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
            maker.bottom.equalTo(tempImageLabel).inset(30)
            maker.width.equalTo(weatherConditionImage.snp.height).multipliedBy(1.0/1.0)
        }
        
        
        view.addSubview(animationView)
        animationView.loopMode = .loop
//        animationView.play()
        animationView.snp.makeConstraints { maker in
            maker.width.equalTo(80)
            maker.width.equalTo(animationView.snp.height).multipliedBy(1.0/1.0)
            maker.right.equalToSuperview().inset(0)
            maker.bottomMargin.equalToSuperview().inset(80)
        }
        
        view.addSubview(shareButton)
        //        shareButton.backgroundColor = .red
        shareButton.setImage(UIImage(named: "share.light.sun"), for: .normal)
        shareButton.snp.makeConstraints { maker in
            maker.width.equalTo(45)
            maker.right.equalToSuperview().inset(10)
            maker.width.equalTo(shareButton.snp.height).multipliedBy(1.0/1.0)
//            maker.center.equalTo(animationView.snp.center)
            maker.bottom.equalTo(switchButton).inset(45)
        }
        
        switchButton.layer.zPosition = 12
        animationView.layer.zPosition = 10
        shareButton.layer.zPosition = 11

        forecastButton.image = UIImage(named: "forecast.cloud")
        forecastButton.target = self
        forecastButton.action = #selector(getForecast)
        forecastButton.tintColor = .white
        
        setToolbarItems([forecastButton], animated: true)
        forecastButton.imageInsets.left = 0
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


