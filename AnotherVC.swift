//
//  AnotherVC.swift
//  WeatherApplication
//
//  Created by UPIT on 15.08.21.
//

import UIKit
import Combine
import Lottie

class AnotherVC: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    @IBOutlet weak var lab5: UILabel!
    

    
    private let viewModel = ViewModel()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Animation object
        let jsonName = "sun.max"
        let animation = Animation.named(jsonName)

        // Load animation to AnimationView
        let animationView = AnimationView(animation: animation)
        
        animationView.frame = CGRect(x: 150, y: 150, width: 200, height: 200)
        

        // Add animationView as subview
        view.addSubview(animationView)

        // Play the animation
        animationView.play()
        
binding()
    }



func binding() {

    viewModel.$currentWeather
        .sink(receiveValue: {[weak self] currentWeather in
            
            self?.cityLabel.text =
                currentWeather.city?.name != nil ?
                "\((currentWeather.city?.name!)!)"
                : ""
            
            self?.tempLabel.text =
                currentWeather.list?[0].main?.temp != nil ?
                "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                : " "

            
            self?.pressureLabel.text =
                currentWeather.list?[0].main?.pressure != nil ?
                "\(Int((currentWeather.list?[0].main?.pressure!)!)) hPa"
                : " "
            
 
            self?.lab1.text =
                currentWeather.list?[0].main?.temp != nil ?
                "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                : " "
            
            self?.lab2.text =
                currentWeather.list?[1].main?.temp != nil ?
                "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                : " "
            self?.lab3.text =
                currentWeather.list?[2].main?.temp != nil ?
                "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                : " "
            self?.lab4.text =
                currentWeather.list?[3].main?.temp != nil ?
                "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                : " "
            self?.lab5.text =
                currentWeather.list?[4].main?.temp != nil ?
                "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
                : " "
          
    
            
            
        }
        )
        .store(in: &cancellable)
}



}
