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
    
    var animation: Animation!
    var animationView: AnimationView!
    
    
    
    
    override func viewDidLoad() {
        
        
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
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
//
//        let label
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
            
            
        }else if (sender.selectedSegmentIndex == 1) {
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

                
            }
            )
            .store(in: &cancellable)
    }

    func binding() {
        textField.textPublisher
            .assign(to: \.city, on: viewModel)
            .store(in: &cancellable)
        
        viewModel.$currentWeather
            .sink(receiveValue: {[weak self] currentWeather in
                
                var one = currentWeather.list?[0].weather?[0].main?.rawValue
                
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
                    
                    
                    
                    
                case "Rain":
                    self?.view.backgroundColor = UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1)
                    
                    self?.tempImageLabel.image = UIImage(named: "temp_rain")
                    self?.windImageLabel.image = UIImage(named: "wind_rain")
                    self?.humidityImageLabel.image = UIImage(named: "humidity_rain")
                    self?.pressureImageLabel.image = UIImage(named: "pressure_rain")
                    
                    self?.cityLabel.textColor = UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1)
                    self?.temperatureLabel.textColor = UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1)
                    self?.humidityLabel.textColor = UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1)
                    self?.pressureLabel.textColor = UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1)
                    self?.windLabel.textColor = UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1)
                    
                    
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
    
    private var cancellable = Set<AnyCancellable>()
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
