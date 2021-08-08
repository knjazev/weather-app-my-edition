//
//  ViewController.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
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
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var switchLabel: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = viewModel.city
        binding()
        
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
                
                self?.weatherConditionImage.image = UIImage(systemName: self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800) ?? "sun.max")
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

