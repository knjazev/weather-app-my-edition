//
//  ViewController.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//

import UIKit
import Combine
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    var array = [WeatherDetail]()
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.isEnabled = true
            textField.becomeFirstResponder()
        }
    }
    
    private let viewModel = ViewModel()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel! {
        didSet {
            cityLabel.isEnabled = true
            cityLabel.becomeFirstResponder()
        }
    }
    @IBOutlet weak var switchLabel: UISegmentedControl!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        textField.text = viewModel.city
        viewModel.weatherAPI.delegate = self
        viewModel.delegatation()
        
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
            overrideUserInterfaceStyle = .dark
            weatherConditionImage.tintColor = .white
        }
    }
    
    @IBAction func getLocation(_ sender: UIButton) {
        
        //        viewModel.city = "Moscow"
        textField.text = ""
        viewModel.locationManager.requestLocation()
        
        
        if let latitude = viewModel.locationManager.location?.coordinate.latitude, let longitude = viewModel.locationManager.location?.coordinate.longitude {
            
            cityLabel.text = ""
            
            print("\(latitude)")
            print("\(longitude)")
            //            latitudeLabel.text = String(format: "%.1f", latitude)
            //            longitudeLabel.text = String(format: "%.1f", longitude)
            latitudeLabel.text = "\(latitude)"
            longitudeLabel.text = "\(longitude)"
            
        }
    }
    
    func binding() {
        textField.textPublisher
            .assign(to: \.city, on: viewModel)
            .store(in: &cancellable)
        
        viewModel.$currentWeather
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
                
                self?.pressureLabel.text =
                    currentWeather.list?[0].main?.pressure != nil ?
                    "\(Int((currentWeather.list?[0].main?.pressure!)!)) hPa"
                    : " "
                
                self?.latitudeLabel.text =
                    currentWeather.city?.coord?.lat != nil ?
                    "\(Double((currentWeather.city?.coord?.lat!)!))"
                    : " "
                self?.longitudeLabel.text =
                    currentWeather.city?.coord?.lon != nil ?
                    "\(Double((currentWeather.city?.coord?.lon!)!))"
                    : " "
                
                self?.weatherConditionImage.image = UIImage(systemName: self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800) ?? "sun.max")
                
                
                self?.array.append(currentWeather)
                
                
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

extension ViewController: WeatherAPIDelegate {
    func didUpdateWeather(_ weatherManager: WeatherAPI, cityName: String) {
        DispatchQueue.main.async {
            self.viewModel.city = cityName
            //            self.cityLabel.text = cityName
        }
    }
    
    func didFailWithError(error: Error){
        print(error.localizedDescription)
    }
}


