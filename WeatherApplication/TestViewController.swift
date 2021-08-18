//
//  TestViewController.swift
//  WeatherApplication
//
//  Created by UPIT on 18.08.21.
//

import UIKit

class TestViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize(name: "sun.max", elementColor: UIColor.ElementColor.sunColor, backgrondColor: UIColor.BackgroundColor.sunColor)
        
    }
    private func initialize(name: String, elementColor: UIColor, backgrondColor: UIColor) {
        
        let tabBar = self.storyboard?.instantiateViewController(withIdentifier:"tabbar") as? TabBarController


        tabBarController?.tabBar.barTintColor = backgrondColor
        tabBarController?.tabBar.selectionIndicatorImage = UIImage(named: "forecast.\(name)")
        tabBarController?.tabBar.tintColor = backgrondColor
        
        view.backgroundColor = backgrondColor
        
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
        
        
        
        
        //City name
        
        cityLabel.text = "San Francisko| 22"
       
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.font = UIFont(name: "WhoopAss", size: 60)
        cityLabel.textColor = elementColor
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
        textField.textColor = backgrondColor
        textField.backgroundColor = elementColor
        textField.textAlignment = .left
        view.addSubview(textField)
        
        textField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.right.equalToSuperview().inset(50)
            maker.left.equalToSuperview().inset(10)
            maker.top.equalTo(cityLabel).inset(60)
        }
        
        
        // location
        
        getLocationButton.setImage(UIImage(named: "location.\(name)"), for: UIControl.State.normal)
        
        getLocationButton.backgroundColor = backgrondColor
        view.addSubview(getLocationButton)
        getLocationButton.snp.makeConstraints { maker in
            
            maker.top.equalTo(cityLabel).inset(60)
            maker.height.equalTo(20)
            maker.right.equalToSuperview().inset(30)
            maker.left.equalTo(textField.snp.right).inset(20)
            maker.centerY.equalTo(textField)
            maker.width.equalTo(getLocationButton.snp.height).multipliedBy(1.0/1.0)
        }
        
        
        //Image Labels
        
        pressureImageLabel.image = UIImage(named: "pressure.\(name)")
        view.addSubview(pressureImageLabel)
        pressureImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(30)
            maker.bottomMargin.equalToSuperview().inset(30)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        humidityImageLabel.image = UIImage(named: "humidity.\(name)")
        view.addSubview(humidityImageLabel)
        humidityImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(30)
            maker.bottom.equalTo(pressureImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        windImageLabel.image = UIImage(named: "wind.\(name)")
        view.addSubview(windImageLabel)
        windImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(30)
            maker.bottom.equalTo(humidityImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        tempImageLabel.image = UIImage(named: "temp.\(name)")
        view.addSubview(tempImageLabel)
        tempImageLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(30)
            maker.bottom.equalTo(windImageLabel).inset(45)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        //Labels with data
        
        pressureLabel.text = "1000 hPa"
        pressureLabel.textColor = elementColor
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
        humidityLabel.textColor = elementColor
        humidityLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        view.addSubview(humidityLabel)
        
        humidityLabel.snp.makeConstraints { maker in
            maker.left.equalTo(humidityImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(humidityImageLabel)
            maker.height.equalTo(humidityImageLabel.snp.height)
        }
        
        windLabel.text = "1000 m/s"
        windLabel.textColor = elementColor
        windLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        view.addSubview(windLabel)
        
        windLabel.snp.makeConstraints { maker in
            maker.left.equalTo(windImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(windImageLabel)
            maker.height.equalTo(windImageLabel.snp.height)
        }
        
        temperatureLabel.text = "1000 ºC"
        temperatureLabel.textColor = elementColor
        temperatureLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        view.addSubview(temperatureLabel)
        
        temperatureLabel.snp.makeConstraints { maker in
            maker.left.equalTo(tempImageLabel).inset(55)
            maker.right.lessThanOrEqualToSuperview().inset(100)
            maker.centerY.equalTo(tempImageLabel)
            maker.height.equalTo(tempImageLabel.snp.height)
        }
        
        weatherConditionImage.image = UIImage(named: "\(name)")
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


//extension UIColor {
//    struct ElementColor {
//        static var sunColor: UIColor  { return UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1) }
//        static var cloudColor: UIColor { return UIColor(red: 232/255, green: 182/255, blue: 182/255, alpha: 1)}
//        static var rainColor: UIColor { return UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1) }
//        static var thunderColor: UIColor { return UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1) }
//        static var fogColor: UIColor { return UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)}
//        static var snowColor: UIColor { return UIColor(red: 83/255, green: 100/255, blue: 135/255, alpha: 1) }
//    }
//    
//    struct BackgroundColor {
//        static var sunColor: UIColor  { return UIColor(red: 254/255, green: 202/255, blue: 202/255, alpha: 1) }
//        static var cloudColor: UIColor { return UIColor(red: 6/255, green: 128/255, blue: 93/255, alpha: 1) }
//        static var rainColor: UIColor { return UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1) }
//        static var thunderColor: UIColor { return UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1) }
//        static var fogColor: UIColor { return UIColor(red: 182/255, green: 182/255, blue: 183/255, alpha: 1) }
//        static var snowColor: UIColor { return UIColor(red: 172/255, green: 217/255, blue: 242/255, alpha: 1) }
//    }
//}
//
//
