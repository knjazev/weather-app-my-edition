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
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var switchLabel: UISegmentedControl!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    var animation: Animation!
    var animationView: AnimationView!
    
    
    
    
    override func viewDidLoad() {
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
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "table") as? TableViewController {
            
            if let cityLabel = cityLabel.text {
                
            }
        }
    }
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
                
                //                self?.jsonName = self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800) ?? "sun.max"
                
                self?.jsonName = (self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800))!
                
                self?.animationView.play()
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
                
                //                self?.jsonName = self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800) ?? "sun.max"
                
                self?.jsonName = (self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800))!
                
                self?.animationView.play()
                print(self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 400))
                
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
