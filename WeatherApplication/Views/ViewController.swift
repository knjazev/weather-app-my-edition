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
    let timeLabel = UILabel()
    let temperatureLabel = UILabel()
    let humidityLabel = UILabel()
    let pressureLabel = UILabel()
    let windLabel = UILabel()
    let switchButton = UIButton(type: .custom)
    let timeImageLabel = UIImageView()
    let tempImageLabel = UIImageView()
    let humidityImageLabel = UIImageView()
    let pressureImageLabel = UIImageView()
    let windImageLabel = UIImageView()
    let getLocationButton = UIButton()
    let shareButton = UIButton()
    //    let animationView = AnimationView(name: "tap2")
    let forecastButton = UIBarButtonItem()
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkMonitor.shared.startMonitoring(view: self)
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
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            overrideUserInterfaceStyle = .light
            StaticContext.isLightMode = true
            setState(conditionID: StaticContext.staticWeatherConditionString, timeOfADay: StaticContext.timeOfAday)
            self.switchButton.isEnabled = true
            
        case true:
            if traitCollection.userInterfaceStyle == .light && StaticContext.getLocationOnView == true {
                overrideUserInterfaceStyle = .dark
                StaticContext.isLightMode = false
                setState(conditionID: StaticContext.staticWeatherConditionString, timeOfADay: StaticContext.timeOfAday)
            }else if traitCollection.userInterfaceStyle == .dark && StaticContext.getLocationOnView == true {
                overrideUserInterfaceStyle = .light
                StaticContext.isLightMode = true
                 setState(conditionID: StaticContext.staticWeatherConditionString, timeOfADay: StaticContext.timeOfAday)
            }else if traitCollection.userInterfaceStyle == .light && StaticContext.getLocationOnView == false {
                overrideUserInterfaceStyle = .dark
                StaticContext.isLightMode = false
                setState(conditionID: StaticContext.staticWeatherConditionString, timeOfADay: StaticContext.timeOfAday)
            }else {
                overrideUserInterfaceStyle = .light
                StaticContext.isLightMode = true
                setState(conditionID: StaticContext.staticWeatherConditionString, timeOfADay: StaticContext.timeOfAday)
            }
            self.switchButton.isEnabled = true
        }
    }
    
    //MARK: Get current location
    
    @objc func getLocation(_ sender: UIButton) {
        
        NetworkMonitor.shared.startMonitoring(view: self)
        
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
                
                StaticContext.staticWeatherConditionID = currentWeather.list?[0].weather?[0].id ?? 800
                StaticContext.staticWeatherConditionString = currentWeather.list?[0].weather?[0].main?.rawValue ?? "Rain"
                
                switch currentWeather.list?[0].sys?.pod {
                case .d:
                    StaticContext.timeOfAday = "d"
                case .n:
                    StaticContext.timeOfAday = "n"
                default:
                    StaticContext.timeOfAday = "d"
                }
                
                StaticContext.trigger = trigrer
                StaticContext.getLocationOnView = screenMode
                StaticContext.cityStatic = currentWeather.city?.name ?? "Casablanca"
                StaticContext.currentUIcolor = UIColor.ElementColor.sunColor
                StaticContext.currentCellTextColor = UIColor.BackgroundColor.sunColor
                
                // table view
                
                for item in currentWeather.list ?? [] {
                    StaticContext.arrayOfConditions.append(item.weather?[0].id ?? 800)
                    StaticContext.objectsArray.append(Objects(sectionName: item.dtTxt?.components(separatedBy: " ")[0] != nil ? "\((item.dtTxt!.components(separatedBy: " ")[0]))" : "", sectionObjects: []))
                }
                
                StaticContext.sectionArray = StaticContext.objectsArray.uniqued()
                var counter = 0
                for item in currentWeather.list ?? [] { 
                    if (item.dtTxt?.components(separatedBy: " ")[0] != nil ? "\((item.dtTxt!.components(separatedBy: " ")[0]))" : "") ==
                        StaticContext.sectionArray[counter].sectionName {
                        
                        StaticContext.sectionArray[counter].sectionObjects.append("\(item.dtTxt?.components(separatedBy: " ")[1].dropLast(3) != nil ? "\((item.dtTxt!.components(separatedBy: " ")[1].dropLast(3)))" : "")  | \(item.main?.temp != nil ? "\(Int((item.main?.temp!)!)) ºC" : "")")
                        
                    }else {
                        counter = counter + 1
                        StaticContext.sectionArray[counter].sectionObjects.append("\(item.dtTxt?.components(separatedBy: " ")[1].dropLast(3) != nil ? "\((item.dtTxt!.components(separatedBy: " ")[1].dropLast(3)))" : "")  | \(item.main?.temp != nil ? "\(Int((item.main?.temp!)!)) ºC" : "")")
                    }
                }

                self?.setState(conditionID: StaticContext.staticWeatherConditionString, timeOfADay: StaticContext.timeOfAday)
            
                self?.cityLabel.text =
                    currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : "Type city name"
                
                self?.timeLabel.text = self?.getDateAndTimeFromTimeZone(timeZoneIdentifier: currentWeather.city?.timezone ?? 10800)
                
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
        
        view.backgroundColor = UIColor.BackgroundColor.rainColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColor.rainColor
        
        //City name
        
        cityLabel.text = "Casablanca"
        cityLabel.textColor = UIColor.ElementColor.rainColor
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.font = UIFont(name: "WhoopAss", size: 60)
        view.addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.top.greaterThanOrEqualToSuperview().inset(60)
            maker.rightMargin.lessThanOrEqualToSuperview().inset(100)
        }
        
        //Textfield
        
        textField.text = ""
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont(name: "Montserrat-Thin", size: 30)
        textField.backgroundColor = UIColor.ElementColor.rainColor
        textField.textAlignment = .left
        view.addSubview(textField)
        
        textField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.right.equalToSuperview().inset(50)
            maker.left.equalToSuperview().inset(10)
            maker.top.equalTo(cityLabel).inset(60)
        }
        
        getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: .normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.rainColor
        view.addSubview(getLocationButton)
        getLocationButton.snp.makeConstraints { maker in
            maker.top.equalTo(cityLabel).inset(60)
            maker.right.equalToSuperview().inset(30)
            maker.left.equalTo(textField.snp.right).inset(20)
            maker.centerY.equalTo(textField)
            maker.width.equalTo(getLocationButton.snp.height).multipliedBy(1.0/1.0)
        }
        
        //Image Labels
        
        pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
        view.addSubview(pressureImageLabel)
        pressureImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.bottomMargin.equalToSuperview().inset(30)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
        view.addSubview(humidityImageLabel)
        humidityImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.bottom.equalTo(pressureImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        windImageLabel.image = UIImage(named: "wind.cloud.rain")
        view.addSubview(windImageLabel)
        windImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.bottom.equalTo(humidityImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        tempImageLabel.image = UIImage(named: "temp.cloud.rain")
        view.addSubview(tempImageLabel)
        tempImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.bottom.equalTo(windImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        timeImageLabel.image = UIImage(named: "time.cloud.rain")
        view.addSubview(timeImageLabel)
        timeImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.bottom.equalTo(tempImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }

        //Light mode
        
        switchButton.setImage(UIImage(named: "cloud.rain"), for: .normal)
        view.addSubview(switchButton)
        
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
        pressureLabel.textColor = UIColor.ElementColor.rainColor
        view.addSubview(pressureLabel)
        
        pressureLabel.snp.makeConstraints { maker in
            maker.left.equalTo(pressureImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(pressureImageLabel)
            maker.height.equalTo(pressureImageLabel.snp.height)
            maker.bottomMargin.equalToSuperview().inset(30)
        }
        
        humidityLabel.text = "100 %"
        humidityLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        humidityLabel.textColor = UIColor.ElementColor.rainColor
        view.addSubview(humidityLabel)
        
        humidityLabel.snp.makeConstraints { maker in
            maker.left.equalTo(humidityImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(humidityImageLabel)
            maker.height.equalTo(humidityImageLabel.snp.height)
        }
        
        windLabel.text = "10 m/s"
        windLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        windLabel.textColor = UIColor.ElementColor.rainColor
        view.addSubview(windLabel)
        
        windLabel.snp.makeConstraints { maker in
            maker.left.equalTo(windImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(windImageLabel)
            maker.height.equalTo(windImageLabel.snp.height)
        }
        
        temperatureLabel.text = "25 ºC"
        temperatureLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        temperatureLabel.textColor = UIColor.ElementColor.rainColor
        view.addSubview(temperatureLabel)
        
        temperatureLabel.snp.makeConstraints { maker in
            maker.left.equalTo(tempImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(tempImageLabel)
            maker.height.equalTo(tempImageLabel.snp.height)
        }
        
        timeLabel.text = "18 MAR 12:00"
        timeLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        timeLabel.textColor = UIColor.ElementColor.rainColor
        view.addSubview(temperatureLabel)
        view.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { maker in
            maker.left.equalTo(timeImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(timeImageLabel)
            maker.height.equalTo(timeLabel.snp.height)
        }
        
        
        weatherConditionImage.image = UIImage(named: "cloud.rain")
        view.addSubview(weatherConditionImage)
        weatherConditionImage.snp.makeConstraints { maker in
            maker.top.equalTo(textField).inset(60)
            maker.right.equalToSuperview().inset(0)
            maker.left.greaterThanOrEqualTo(0)
            maker.bottom.equalTo(timeImageLabel).inset(30)
            maker.width.equalTo(weatherConditionImage.snp.height).multipliedBy(1.0/1.0)
        }
        
        //        view.addSubview(animationView)
        //        animationView.loopMode = .loop
        ////        animationView.play()
        //        animationView.snp.makeConstraints { maker in
        //            maker.width.equalTo(80)
        //            maker.width.equalTo(animationView.snp.height).multipliedBy(1.0/1.0)
        //            maker.right.equalToSuperview().inset(0)
        //            maker.bottomMargin.equalToSuperview().inset(80)
        //        }
        
        view.addSubview(shareButton)
        shareButton.setImage(UIImage(named: "share.light.cloud.rain"), for: .normal)
        shareButton.snp.makeConstraints { maker in
            maker.width.equalTo(45)
            maker.right.equalToSuperview().inset(10)
            maker.width.equalTo(shareButton.snp.height).multipliedBy(1.0/1.0)
            maker.bottom.equalTo(switchButton).inset(45)
        }
        
        switchButton.layer.zPosition = 12
        //        animationView.layer.zPosition = 10
        shareButton.layer.zPosition = 11
        forecastButton.image = UIImage(named: "forecast.cloud")
        forecastButton.target = self
        forecastButton.action = #selector(getForecast)
        forecastButton.tintColor = .white
        
        setToolbarItems([forecastButton], animated: true)
        forecastButton.imageInsets.left = 0
    }
    
    func getDateAndTimeFromTimeZone(timeZoneIdentifier: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm | dd MMM"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZoneIdentifier)
        
        return dateFormatter.string(from: Date())
    }
}



