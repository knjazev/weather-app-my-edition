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
    
    @IBOutlet weak var textField: UITextField!
    
    private let viewModel = ViewModel()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!

    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!

    @IBOutlet weak var switchLabel: UISegmentedControl!

    @IBOutlet weak var tempImageLabel: UIImageView!
    @IBOutlet weak var humidityImageLabel: UIImageView!
    @IBOutlet weak var pressureImageLabel: UIImageView!
    @IBOutlet weak var windImageLabel: UIImageView!

    @IBOutlet weak var getLocationButton: UIButton!
    
    
    var animation: Animation!
    var animationView: AnimationView!
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        
    // font name WhoopAss
        
        super.viewDidLoad()
        
        textField.delegate = self
        textField.text = viewModel.city
        viewModel.delegatation()
        
        
        animation = Animation.named(jsonName)
        animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: 150, y: 150, width: 150, height: 150)
        
        
        //        view.addSubview((animationView)!)
        
        
        binding()

        if traitCollection.userInterfaceStyle == .dark {
            switchLabel.selectedSegmentIndex = 1
            weatherConditionImage.tintColor = .white
        }else if (traitCollection.userInterfaceStyle == .light) {
            switchLabel.selectedSegmentIndex = 0
            weatherConditionImage.tintColor = .black
        }else if (traitCollection.userInterfaceStyle == .unspecified) {
            switchLabel.selectedSegmentIndex = 0
            weatherConditionImage.tintColor = .black
        }
        
    }
    
    
    private func initialize() {
        
        view.backgroundColor = .white
        let temperatureLabel = UILabel()
 
        let humidityLabel = UILabel()
        let pressureLabel = UILabel()

        let windLabel = UILabel()
        let weatherConditionImage = UIImageView()
        let cityLabel = UILabel()
        
        let switchLabel = UISegmentedControl()

        let tempImageLabel = UIImageView()
        let humidityImageLabel = UIImageView()
        let pressureImageLabel = UIImageView()
        let windImageLabel = UIImageView()
        let getLocationButton = UIButton()
        
        view.addSubview(cityLabel)
        cityLabel.text = "One"
        cityLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(5)
            maker.top.equalToSuperview().inset(5)
            maker.rightMargin.lessThanOrEqualToSuperview().inset(5)
        }
        
        
        
        
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
    
    
    @IBAction func getLocation(_ sender: UIButton) {

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
//        viewModel.$currentWeather
            .sink(receiveValue: {[weak self] currentWeather in
                
                switch currentWeather.list?[0].weather?[0].main?.rawValue {
                case "Clear":
                    self?.view.backgroundColor = UIColor(red: 254/255, green: 202/255, blue: 202/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_sun")
                    self?.windImageLabel.image = UIImage(named: "wind_sun")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_sun")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_sun")
                    self?.getLocationButton.setImage(UIImage(named: "location.sun"), for: .normal)
                    
                    self?.cityLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.temperatureLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.getLocationButton.tintColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 0.7)
                    
                    
                case "Rain":
                    self?.view.backgroundColor = UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_rain")
                    self?.windImageLabel.image = UIImage(named: "wind_rain")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_rain")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_rain")

                    self?.getLocationButton.setImage(UIImage(named: "location.rain"), for: UIControl.State.normal)
                  
                    self?.cityLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.temperatureLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.getLocationButton.tintColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 0.7)
                    
                    
                case "Clouds":
                    self?.view.backgroundColor = UIColor(red: 6/255, green: 128/255, blue: 93/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_cloud")
                    self?.windImageLabel.image = UIImage(named: "wind_cloud")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_cloud")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_cloud")
                    self?.getLocationButton.setImage(UIImage(named: "location.cloud"), for: .normal)
                    
                    self?.cityLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    
                    self?.temperatureLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.getLocationButton.tintColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 0.7)
                    
                case "Thunderstorm":
                    self?.view.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_bolt")
                    self?.windImageLabel.image = UIImage(named: "wind_bolt")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_bolt")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_bolt")
                    self?.getLocationButton.setImage(UIImage(named: "location.bolt"), for: .normal)
                    
                    
                    self?.cityLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    
                    self?.temperatureLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.getLocationButton.tintColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 0.7)
                    
                case "Snow":
                    self?.view.backgroundColor = UIColor(red: 172/255, green: 217/255, blue: 242/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_snow")
                    self?.windImageLabel.image = UIImage(named: "wind_snow")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_snow")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_snow")
                    self?.getLocationButton.setImage(UIImage(named: "location.snow"), for: .normal)
                    
                    self?.cityLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    
                    self?.temperatureLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.getLocationButton.tintColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 0.7)
                    
                case "Fog", "Tornado", "Haze", "Dust", "Fog",  "Sand", "Dust", "Ash", "Squall" :
                    
                    self?.view.backgroundColor = UIColor(red: 182/255, green: 182/255, blue: 183/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_snow")
                    self?.windImageLabel.image = UIImage(named: "wind_snow")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_snow")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_snow")
                    self?.getLocationButton.setImage(UIImage(named: "location.fog"), for: .normal)
                    
                    self?.cityLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    
                    self?.temperatureLabel.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.getLocationButton.tintColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 0.7)
                    
                    
                
                    
                default:
                    print("default")
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
                    currentWeather.list?[0].main?.humidity != nil ?
                    "\(Int((currentWeather.list?[0].main?.humidity!)!)) %"
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
                    
                    self?.view.backgroundColor = UIColor(red: 254/255, green: 202/255, blue: 202/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_sun")
                    self?.windImageLabel.image = UIImage(named: "wind_sun")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_sun")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_sun")
                    
                    self?.cityLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.temperatureLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 0.7)
                    
                    
                case "Rain":
                    self?.view.backgroundColor = UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_rain")
                    self?.windImageLabel.image = UIImage(named: "wind_rain")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_rain")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_rain")
                    
                    self?.cityLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.temperatureLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 0.7)
                    
                    
                case "Clouds":
                    self?.view.backgroundColor = UIColor(red: 6/255, green: 128/255, blue: 93/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_cloud")
                    self?.windImageLabel.image = UIImage(named: "wind_cloud")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_cloud")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_cloud")
                    
                    self?.cityLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    
                    self?.temperatureLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 254/255, green: 153/255, blue: 169/255, alpha: 0.7)
                    
                case "Thunderstorm":
                    self?.view.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_bolt")
                    self?.windImageLabel.image = UIImage(named: "wind_bolt")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_bolt")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_bolt")
                    
                    self?.cityLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    
                    self?.temperatureLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 0.7)
                    
                case "Snow":
                    self?.view.backgroundColor = UIColor(red: 172/255, green: 217/255, blue: 242/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_snow")
                    self?.windImageLabel.image = UIImage(named: "wind_snow")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_snow")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_snow")
                    
                    self?.cityLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    
                    self?.temperatureLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 0.7)
                    
                case "Fog", "Tornado", "Haze", "Dust", "Fog",  "Sand", "Dust", "Ash", "Squall" :
                    
                    self?.view.backgroundColor = UIColor(red: 182/255, green: 182/255, blue: 183/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_snow")
                    self?.windImageLabel.image = UIImage(named: "wind_snow")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_snow")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_snow")
                    
                    self?.cityLabel.textColor = UIColor(red: 82/255, green: 102/255, blue: 140/255, alpha: 1)
                    
                    self?.temperatureLabel.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
                    self?.textField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 0.7)

                default:
                    print("default")
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
                    currentWeather.list?[0].main?.humidity != nil ?
                    "\(Int((currentWeather.list?[0].main?.humidity!)!)) %"
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
