//
//  UIViewExtension.swift
//  WeatherApplication
//
//  Created by UPIT on 24.08.21.
//

import UIKit

extension ViewController {
    
    //MARK: Day mode
    
    func setClearLightState() {
        view.backgroundColor = UIColor.BackgroundColor.sunColor
        
        getLocationButton.setImage(UIImage(named: "location.sun.max"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.sunColor
        
        tempImageLabel.image = UIImage(named: "temp.sun.max")
        windImageLabel.image = UIImage(named: "wind.sun.max")
        humidityImageLabel.image = UIImage(named: "humidity.sun.max")
        pressureImageLabel.image = UIImage(named: "pressure.sun.max")
        switchButton.setImage(UIImage(named: "moon.sun"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.sun"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "sun.max")
        
        cityLabel.textColor = UIColor.ElementColor.sunColor
        temperatureLabel.textColor = UIColor.ElementColor.sunColor
        humidityLabel.textColor = UIColor.ElementColor.sunColor
        pressureLabel.textColor = UIColor.ElementColor.sunColor
        windLabel.textColor = UIColor.ElementColor.sunColor
        textField.backgroundColor = UIColor.ElementColor.sunColor
        switchButton.tintColor = UIColor.ElementColor.sunColor
//        shareButton.tintColor = UIColor.ElementColor.sunColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.sunColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.sunColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColor.sunColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.sunColor
        forecastButton.tintColor = UIColor.ElementColor.sunColor

        textField.textColor = UIColor.BackgroundColor.sunColor
        
        StaticContext.currentUIcolor = UIColor.ElementColor.sunColor
    }
    func setRainLightState() {
        view.backgroundColor = UIColor.BackgroundColor.rainColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.rainColor
        tempImageLabel.image = UIImage(named: "temp.cloud.rain")
        windImageLabel.image = UIImage(named: "wind.cloud.rain")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
        switchButton.setImage(UIImage(named: "moon.cloud.rain"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud.rain"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.rain")
        
        cityLabel.textColor = UIColor.ElementColor.rainColor
        temperatureLabel.textColor = UIColor.ElementColor.rainColor
        humidityLabel.textColor = UIColor.ElementColor.rainColor
        pressureLabel.textColor = UIColor.ElementColor.rainColor
        windLabel.textColor = UIColor.ElementColor.rainColor
        textField.backgroundColor = UIColor.ElementColor.rainColor
        textField.textColor = UIColor.BackgroundColor.rainColor
        switchButton.tintColor = UIColor.ElementColor.rainColor
//        shareButton.tintColor = UIColor.ElementColor.rainColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.rainColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.rainColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColor.rainColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.rainColor
        forecastButton.tintColor = UIColor.ElementColor.rainColor

        StaticContext.currentUIcolor = UIColor.ElementColor.rainColor
    }
    
    
    func setCloudsLightState() {
        view.backgroundColor = UIColor.BackgroundColor.cloudColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.cloudColor
        tempImageLabel.image = UIImage(named: "temp.cloud")
        windImageLabel.image = UIImage(named: "wind.cloud")
        humidityImageLabel.image = UIImage(named: "humidity.cloud")
        pressureImageLabel.image = UIImage(named: "pressure.cloud")
        weatherConditionImage.image = UIImage(named: "cloud")
        switchButton.setImage(UIImage(named: "moon.cloud"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud")
        
        cityLabel.textColor = UIColor.ElementColor.cloudColor
        temperatureLabel.textColor = UIColor.ElementColor.cloudColor
        humidityLabel.textColor = UIColor.ElementColor.cloudColor
        pressureLabel.textColor = UIColor.ElementColor.cloudColor
        windLabel.textColor = UIColor.ElementColor.cloudColor
        textField.backgroundColor = UIColor.ElementColor.cloudColor
        textField.textColor = UIColor.BackgroundColor.cloudColor
        switchButton.tintColor = UIColor.ElementColor.cloudColor
//        shareButton.tintColor = UIColor.ElementColor.cloudColor
        
       
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.cloudColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.cloudColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColor.cloudColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.cloudColor
        forecastButton.tintColor = UIColor.ElementColor.cloudColor
        
        StaticContext.currentUIcolor = UIColor.ElementColor.cloudColor
    }
    
    func setThunderLightState() {
        view.backgroundColor = UIColor.BackgroundColor.thunderColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.bolt"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.thunderColor
        tempImageLabel.image = UIImage(named: "temp.cloud.bolt")
        windImageLabel.image = UIImage(named: "wind.cloud.bolt")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")
        switchButton.setImage(UIImage(named: "moon.cloud.bolt"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud.bolt"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.bolt")
        
        cityLabel.textColor = UIColor.ElementColor.thunderColor
        
        temperatureLabel.textColor = UIColor.ElementColor.thunderColor
        humidityLabel.textColor = UIColor.ElementColor.thunderColor
        pressureLabel.textColor = UIColor.ElementColor.thunderColor
        windLabel.textColor = UIColor.ElementColor.thunderColor
        textField.backgroundColor = UIColor.ElementColor.thunderColor
        textField.textColor = UIColor.BackgroundColor.thunderColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColor.thunderColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.thunderColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.thunderColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColor.thunderColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.thunderColor
        forecastButton.tintColor = UIColor.ElementColor.thunderColor
        
        StaticContext.currentUIcolor = UIColor.ElementColor.thunderColor
    }
    
    func setSnowLightState() {
        view.backgroundColor = UIColor.BackgroundColor.snowColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.snow"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.snowColor
        tempImageLabel.image = UIImage(named: "temp.cloud.snow")
        windImageLabel.image = UIImage(named: "wind.cloud.snow")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")
        switchButton.setImage(UIImage(named: "moon.cloud.snow"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud.snow"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.snow")
        
        cityLabel.textColor = UIColor.ElementColor.snowColor
        
        temperatureLabel.textColor = UIColor.ElementColor.snowColor
        humidityLabel.textColor = UIColor.ElementColor.snowColor
        pressureLabel.textColor = UIColor.ElementColor.snowColor
        windLabel.textColor = UIColor.ElementColor.snowColor
        textField.backgroundColor = UIColor.ElementColor.snowColor
        textField.textColor = UIColor.BackgroundColor.snowColor
        switchButton.tintColor = UIColor.ElementColor.snowColor
        shareButton.tintColor = UIColor.ElementColor.snowColor
//        forecastButton.tintColor = UIColor.BackgroundColor.snowColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.snowColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.snowColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColor.snowColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.snowColor
        forecastButton.tintColor = UIColor.ElementColor.snowColor
         
        StaticContext.currentUIcolor = UIColor.ElementColor.snowColor
    }
    
    func setFogLightState() {
        view.backgroundColor = UIColor.BackgroundColor.fogColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.fog"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColor.fogColor
        tempImageLabel.image = UIImage(named: "temp.cloud.fog")
        windImageLabel.image = UIImage(named: "wind.cloud.fog")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")
        switchButton.setImage(UIImage(named: "moon.cloud.fog"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud.fog"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.fog")
        
        cityLabel.textColor = UIColor.ElementColor.fogColor
        
        temperatureLabel.textColor = UIColor.ElementColor.fogColor
        humidityLabel.textColor = UIColor.ElementColor.fogColor
        pressureLabel.textColor = UIColor.ElementColor.fogColor
        windLabel.textColor = UIColor.ElementColor.fogColor
        textField.backgroundColor = UIColor.ElementColor.fogColor
        textField.textColor = UIColor.BackgroundColor.fogColor
        switchButton.tintColor = UIColor.ElementColor.fogColor
//        shareButton.tintColor = UIColor.ElementColor.fogColor
    
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.fogColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.fogColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColor.fogColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.fogColor
        forecastButton.tintColor = UIColor.ElementColor.fogColor
        
        StaticContext.currentUIcolor = UIColor.ElementColor.fogColor

    }
    
    func setClearDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.sunColor
        
        getLocationButton.setImage(UIImage(named: "location.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.sunColor
        tempImageLabel.image = UIImage(named: "temp.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        windImageLabel.image = UIImage(named: "wind.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        humidityImageLabel.image = UIImage(named: "humidity.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        pressureImageLabel.image = UIImage(named: "pressure.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        weatherConditionImage.image = UIImage(named: "sun.max.dark")
        switchButton.setImage(UIImage(named: "sun.sun"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.sun"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "sun.max.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.sunColor
        temperatureLabel.textColor = UIColor.ElementColorDark.sunColor
        humidityLabel.textColor = UIColor.ElementColorDark.sunColor
        pressureLabel.textColor = UIColor.ElementColorDark.sunColor
        windLabel.textColor = UIColor.ElementColorDark.sunColor
        textField.backgroundColor = UIColor.ElementColorDark.sunColor
        textField.textColor = UIColor.BackgroundColorDark.sunColor
        switchButton.tintColor = UIColor.ElementColorDark.sunColor
//        shareButton.tintColor = UIColor.ElementColorDark.sunColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColorDark.sunColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.sunColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColorDark.sunColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.sunColor
        forecastButton.tintColor = UIColor.ElementColorDark.sunColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.sunColor
    }
    func setCloudsDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.cloudColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.cloudColor
        tempImageLabel.image = UIImage(named: "temp.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        windImageLabel.image = UIImage(named: "wind.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        weatherConditionImage.image = UIImage(named: "cloud.dark")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        switchButton.setImage(UIImage(named: "sun.cloud"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.cloudColor
        temperatureLabel.textColor = UIColor.ElementColorDark.cloudColor
        humidityLabel.textColor = UIColor.ElementColorDark.cloudColor
        pressureLabel.textColor = UIColor.ElementColorDark.cloudColor
        windLabel.textColor = UIColor.ElementColorDark.cloudColor
        textField.backgroundColor = UIColor.ElementColorDark.cloudColor
        textField.textColor = UIColor.BackgroundColorDark.cloudColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.cloudColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColorDark.cloudColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.cloudColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColorDark.cloudColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.cloudColor
        forecastButton.tintColor = UIColor.ElementColorDark.cloudColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.cloudColor
        
    }
    func setRainDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.rainColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.rainColor
        tempImageLabel.image = UIImage(named: "temp.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        windImageLabel.image = UIImage(named: "wind.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        weatherConditionImage.image = UIImage(named: "cloud.rain.dark")?.withTintColor(UIColor.ElementColorDark.rainColor)
        switchButton.setImage(UIImage(named: "sun.cloud.rain"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud.rain"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.rain.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.rainColor
        temperatureLabel.textColor = UIColor.ElementColorDark.rainColor
        humidityLabel.textColor = UIColor.ElementColorDark.rainColor
        pressureLabel.textColor = UIColor.ElementColorDark.rainColor
        windLabel.textColor = UIColor.ElementColorDark.rainColor
        textField.backgroundColor = UIColor.ElementColorDark.rainColor
        textField.textColor = UIColor.BackgroundColorDark.rainColor
        switchButton.tintColor = UIColor.ElementColorDark.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.rainColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColorDark.rainColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.rainColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColorDark.rainColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.rainColor
        forecastButton.tintColor = UIColor.ElementColorDark.rainColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.rainColor
    }
    func setThunderDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.thunderColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.thunderColor
        tempImageLabel.image = UIImage(named: "temp.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        windImageLabel.image = UIImage(named: "wind.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        weatherConditionImage.image = UIImage(named: "cloud.bolt.dark")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        switchButton.setImage(UIImage(named: "sun.cloud.bolt"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud.bolt"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.bolt.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.thunderColor
        temperatureLabel.textColor = UIColor.ElementColorDark.thunderColor
        humidityLabel.textColor = UIColor.ElementColorDark.thunderColor
        pressureLabel.textColor = UIColor.ElementColorDark.thunderColor
        windLabel.textColor = UIColor.ElementColorDark.thunderColor
        textField.backgroundColor = UIColor.ElementColorDark.thunderColor
        textField.textColor = UIColor.BackgroundColorDark.thunderColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.thunderColor
//
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColorDark.thunderColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.thunderColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColorDark.thunderColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.thunderColor
        forecastButton.tintColor = UIColor.ElementColorDark.thunderColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.thunderColor
    }
    func setFogDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.fogColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.fogColor
        tempImageLabel.image = UIImage(named: "temp.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        windImageLabel.image = UIImage(named: "wind.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        weatherConditionImage.image = UIImage(named: "cloud.fog.dark")?.withTintColor(UIColor.ElementColorDark.fogColor)
        switchButton.setImage(UIImage(named: "sun.cloud.fog"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud.fog"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.fog.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.fogColor
        temperatureLabel.textColor = UIColor.ElementColorDark.fogColor
        humidityLabel.textColor = UIColor.ElementColorDark.fogColor
        pressureLabel.textColor = UIColor.ElementColorDark.fogColor
        windLabel.textColor = UIColor.ElementColorDark.fogColor
        textField.backgroundColor = UIColor.ElementColorDark.fogColor
        textField.textColor = UIColor.BackgroundColorDark.fogColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.fogColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColorDark.fogColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.fogColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColorDark.fogColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.fogColor
        forecastButton.tintColor = UIColor.ElementColorDark.fogColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.fogColor
    }
    func setSnowDarkState() {
        view.backgroundColor = UIColor.BackgroundColorDark.snowColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.BackgroundColorDark.snowColor
        tempImageLabel.image = UIImage(named: "temp.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        windImageLabel.image = UIImage(named: "wind.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        weatherConditionImage.image = UIImage(named: "cloud.snow.dark")?.withTintColor(UIColor.ElementColorDark.snowColor)
        switchButton.setImage(UIImage(named: "sun.cloud.snow"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud.snow"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "cloud.snow.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.snowColor
        temperatureLabel.textColor = UIColor.ElementColorDark.snowColor
        humidityLabel.textColor = UIColor.ElementColorDark.snowColor
        pressureLabel.textColor = UIColor.ElementColorDark.snowColor
        windLabel.textColor = UIColor.ElementColorDark.snowColor
        textField.backgroundColor = UIColor.ElementColorDark.snowColor
        textField.textColor = UIColor.BackgroundColorDark.snowColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.snowColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColorDark.snowColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.snowColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColorDark.snowColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.snowColor
        forecastButton.tintColor = UIColor.ElementColorDark.snowColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.snowColor
    }
    
    
    //MARK: Night mode
    
    func setClearLightStateNight() {
        view.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.sun.max"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        
        tempImageLabel.image = UIImage(named: "temp.sun.max")
        windImageLabel.image = UIImage(named: "wind.sun.max")
        humidityImageLabel.image = UIImage(named: "humidity.sun.max")
        pressureImageLabel.image = UIImage(named: "pressure.sun.max")
        switchButton.setImage(UIImage(named: "moon.sun"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.sun"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.sun")
        
        cityLabel.textColor = UIColor.ElementColor.sunColor
        temperatureLabel.textColor = UIColor.ElementColor.sunColor
        humidityLabel.textColor = UIColor.ElementColor.sunColor
        pressureLabel.textColor = UIColor.ElementColor.sunColor
        windLabel.textColor = UIColor.ElementColor.sunColor
        textField.backgroundColor = UIColor.ElementColor.sunColor
        switchButton.tintColor = UIColor.ElementColor.sunColor
//        shareButton.tintColor = UIColor.ElementColor.sunColor
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.sunColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.sunColor
        navigationController?.toolbar.barTintColor = UIColor.BackgroundColor.sunColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.sunColor
        forecastButton.tintColor = UIColor.ElementColor.sunColor

        textField.textColor = UIColor.BackgroundColor.sunColor
        
        StaticContext.currentUIcolor = UIColor.ElementColor.sunColor
    }
    func setRainLightStateNight() {
        view.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.rain"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud.rain")
        windImageLabel.image = UIImage(named: "wind.cloud.rain")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")
        switchButton.setImage(UIImage(named: "moon.cloud.rain"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud.rain"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.rain")
        
        cityLabel.textColor = UIColor.ElementColor.rainColor
        temperatureLabel.textColor = UIColor.ElementColor.rainColor
        humidityLabel.textColor = UIColor.ElementColor.rainColor
        pressureLabel.textColor = UIColor.ElementColor.rainColor
        windLabel.textColor = UIColor.ElementColor.rainColor
        textField.backgroundColor = UIColor.ElementColor.rainColor
        textField.textColor = UIColor.BackgroundColor.rainColor
        switchButton.tintColor = UIColor.ElementColor.rainColor
//        shareButton.tintColor = UIColor.ElementColor.rainColor
        
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.rainColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.rainColor
        forecastButton.tintColor = UIColor.ElementColor.rainColor

        StaticContext.currentUIcolor = UIColor.ElementColor.rainColor
    }
    
    
    func setCloudsLightStateNight() {
        view.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud")
        windImageLabel.image = UIImage(named: "wind.cloud")
        humidityImageLabel.image = UIImage(named: "humidity.cloud")
        pressureImageLabel.image = UIImage(named: "pressure.cloud")
        weatherConditionImage.image = UIImage(named: "cloud")
        switchButton.setImage(UIImage(named: "moon.cloud"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud")
        
        cityLabel.textColor = UIColor.ElementColor.cloudColor
        temperatureLabel.textColor = UIColor.ElementColor.cloudColor
        humidityLabel.textColor = UIColor.ElementColor.cloudColor
        pressureLabel.textColor = UIColor.ElementColor.cloudColor
        windLabel.textColor = UIColor.ElementColor.cloudColor
        textField.backgroundColor = UIColor.ElementColor.cloudColor
        textField.textColor = UIColor.BackgroundColor.cloudColor
        switchButton.tintColor = UIColor.ElementColor.cloudColor
//        shareButton.tintColor = UIColor.ElementColor.cloudColor
        
       
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.cloudColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.cloudColor
        forecastButton.tintColor = UIColor.ElementColor.cloudColor
        
        StaticContext.currentUIcolor = UIColor.ElementColor.cloudColor
    }
    
    func setThunderLightStateNight() {
        view.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.bolt"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud.bolt")
        windImageLabel.image = UIImage(named: "wind.cloud.bolt")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")
        switchButton.setImage(UIImage(named: "moon.cloud.bolt"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud.bolt"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.bolt")
        
        cityLabel.textColor = UIColor.ElementColor.thunderColor
        
        temperatureLabel.textColor = UIColor.ElementColor.thunderColor
        humidityLabel.textColor = UIColor.ElementColor.thunderColor
        pressureLabel.textColor = UIColor.ElementColor.thunderColor
        windLabel.textColor = UIColor.ElementColor.thunderColor
        textField.backgroundColor = UIColor.ElementColor.thunderColor
        textField.textColor = UIColor.BackgroundColor.thunderColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColor.thunderColor
        
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.thunderColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.thunderColor
        forecastButton.tintColor = UIColor.ElementColor.thunderColor
        
        StaticContext.currentUIcolor = UIColor.ElementColor.thunderColor
    }
    
    func setSnowLightStateNight() {
        view.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.snow"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud.snow")
        windImageLabel.image = UIImage(named: "wind.cloud.snow")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")
        switchButton.setImage(UIImage(named: "moon.cloud.snow"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud.snow"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.snow")
        
        cityLabel.textColor = UIColor.ElementColor.snowColor
        
        temperatureLabel.textColor = UIColor.ElementColor.snowColor
        humidityLabel.textColor = UIColor.ElementColor.snowColor
        pressureLabel.textColor = UIColor.ElementColor.snowColor
        windLabel.textColor = UIColor.ElementColor.snowColor
        textField.backgroundColor = UIColor.ElementColor.snowColor
        textField.textColor = UIColor.BackgroundColor.snowColor
        switchButton.tintColor = UIColor.ElementColor.snowColor
        shareButton.tintColor = UIColor.ElementColor.snowColor
//        forecastButton.tintColor = UIColor.BackgroundColor.snowColor
        
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.snowColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.snowColor
        forecastButton.tintColor = UIColor.ElementColor.snowColor
         
        StaticContext.currentUIcolor = UIColor.ElementColor.snowColor
    }
    
    func setFogLightStateNight() {
        view.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.fog"), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyLight.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud.fog")
        windImageLabel.image = UIImage(named: "wind.cloud.fog")
        humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")
        pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")
        switchButton.setImage(UIImage(named: "moon.cloud.fog"), for: .normal)
        shareButton.setImage(UIImage(named: "share.light.cloud.fog"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.fog")
        
        cityLabel.textColor = UIColor.ElementColor.fogColor
        
        temperatureLabel.textColor = UIColor.ElementColor.fogColor
        humidityLabel.textColor = UIColor.ElementColor.fogColor
        pressureLabel.textColor = UIColor.ElementColor.fogColor
        windLabel.textColor = UIColor.ElementColor.fogColor
        textField.backgroundColor = UIColor.ElementColor.fogColor
        textField.textColor = UIColor.BackgroundColor.fogColor
        switchButton.tintColor = UIColor.ElementColor.fogColor
//        shareButton.tintColor = UIColor.ElementColor.fogColor
    
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColor.fogColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyLight.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColor.fogColor
        forecastButton.tintColor = UIColor.ElementColor.fogColor
        
        StaticContext.currentUIcolor = UIColor.ElementColor.fogColor

    }
    
    func setClearDarkStateNight() {
        view.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        windImageLabel.image = UIImage(named: "wind.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        humidityImageLabel.image = UIImage(named: "humidity.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        pressureImageLabel.image = UIImage(named: "pressure.sun.max")?.withTintColor(UIColor.ElementColorDark.sunColor)
        weatherConditionImage.image = UIImage(named: "sun.max.dark")
        switchButton.setImage(UIImage(named: "sun.sun"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.sun"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.sun.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.sunColor
        temperatureLabel.textColor = UIColor.ElementColorDark.sunColor
        humidityLabel.textColor = UIColor.ElementColorDark.sunColor
        pressureLabel.textColor = UIColor.ElementColorDark.sunColor
        windLabel.textColor = UIColor.ElementColorDark.sunColor
        textField.backgroundColor = UIColor.ElementColorDark.sunColor
        textField.textColor = UIColor.BackgroundColorDark.sunColor
        switchButton.tintColor = UIColor.ElementColorDark.sunColor
//        shareButton.tintColor = UIColor.ElementColorDark.sunColor
        
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.sunColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.sunColor
        forecastButton.tintColor = UIColor.ElementColorDark.sunColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.sunColor
    }
    func setCloudsDarkStateNight() {
        view.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        windImageLabel.image = UIImage(named: "wind.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        weatherConditionImage.image = UIImage(named: "cloud.dark")?.withTintColor(UIColor.ElementColorDark.cloudColor)
        switchButton.setImage(UIImage(named: "sun.cloud"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.cloudColor
        temperatureLabel.textColor = UIColor.ElementColorDark.cloudColor
        humidityLabel.textColor = UIColor.ElementColorDark.cloudColor
        pressureLabel.textColor = UIColor.ElementColorDark.cloudColor
        windLabel.textColor = UIColor.ElementColorDark.cloudColor
        textField.backgroundColor = UIColor.ElementColorDark.cloudColor
        textField.textColor = UIColor.BackgroundColorDark.cloudColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.cloudColor
        
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.cloudColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.cloudColor
        forecastButton.tintColor = UIColor.ElementColorDark.cloudColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.cloudColor
        
    }
    func setRainDarkStateNight() {
        view.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        windImageLabel.image = UIImage(named: "wind.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.rain")?.withTintColor(UIColor.ElementColorDark.rainColor)
        weatherConditionImage.image = UIImage(named: "cloud.rain.dark")?.withTintColor(UIColor.ElementColorDark.rainColor)
        switchButton.setImage(UIImage(named: "sun.cloud.rain"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud.rain"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.rain.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.rainColor
        temperatureLabel.textColor = UIColor.ElementColorDark.rainColor
        humidityLabel.textColor = UIColor.ElementColorDark.rainColor
        pressureLabel.textColor = UIColor.ElementColorDark.rainColor
        windLabel.textColor = UIColor.ElementColorDark.rainColor
        textField.backgroundColor = UIColor.ElementColorDark.rainColor
        textField.textColor = UIColor.BackgroundColorDark.rainColor
        switchButton.tintColor = UIColor.ElementColorDark.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.rainColor
        
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.rainColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.rainColor
        forecastButton.tintColor = UIColor.ElementColorDark.rainColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.rainColor
    }
    func setThunderDarkStateNight() {
        view.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        windImageLabel.image = UIImage(named: "wind.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.bolt")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        weatherConditionImage.image = UIImage(named: "cloud.bolt.dark")?.withTintColor(UIColor.ElementColorDark.thunderColor)
        switchButton.setImage(UIImage(named: "sun.cloud.bolt"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud.bolt"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.bolt.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.thunderColor
        temperatureLabel.textColor = UIColor.ElementColorDark.thunderColor
        humidityLabel.textColor = UIColor.ElementColorDark.thunderColor
        pressureLabel.textColor = UIColor.ElementColorDark.thunderColor
        windLabel.textColor = UIColor.ElementColorDark.thunderColor
        textField.backgroundColor = UIColor.ElementColorDark.thunderColor
        textField.textColor = UIColor.BackgroundColorDark.thunderColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.thunderColor
//
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.thunderColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.thunderColor
        forecastButton.tintColor = UIColor.ElementColorDark.thunderColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.thunderColor
    }
    func setFogDarkStateNight() {
        view.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        windImageLabel.image = UIImage(named: "wind.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.fog")?.withTintColor(UIColor.ElementColorDark.fogColor)
        weatherConditionImage.image = UIImage(named: "cloud.fog.dark")?.withTintColor(UIColor.ElementColorDark.fogColor)
        switchButton.setImage(UIImage(named: "sun.cloud.fog"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud.fog"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.fog.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.fogColor
        temperatureLabel.textColor = UIColor.ElementColorDark.fogColor
        humidityLabel.textColor = UIColor.ElementColorDark.fogColor
        pressureLabel.textColor = UIColor.ElementColorDark.fogColor
        windLabel.textColor = UIColor.ElementColorDark.fogColor
        textField.backgroundColor = UIColor.ElementColorDark.fogColor
        textField.textColor = UIColor.BackgroundColorDark.fogColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.fogColor
        
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.fogColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.fogColor
        forecastButton.tintColor = UIColor.ElementColorDark.fogColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.fogColor
    }
    func setSnowDarkStateNight() {
        view.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        
        getLocationButton.setImage(UIImage(named: "location.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor), for: UIControl.State.normal)
        getLocationButton.backgroundColor = UIColor.NightSkyDark.nightSkyColor
        tempImageLabel.image = UIImage(named: "temp.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        windImageLabel.image = UIImage(named: "wind.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        humidityImageLabel.image = UIImage(named: "humidity.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        pressureImageLabel.image = UIImage(named: "pressure.cloud.snow")?.withTintColor(UIColor.ElementColorDark.snowColor)
        weatherConditionImage.image = UIImage(named: "cloud.snow.dark")?.withTintColor(UIColor.ElementColorDark.snowColor)
        switchButton.setImage(UIImage(named: "sun.cloud.snow"), for: .normal)
        shareButton.setImage(UIImage(named: "share.dark.cloud.snow"), for: .normal)
        
        weatherConditionImage.image = UIImage(named: "night.cloud.snow.dark")
        
        cityLabel.textColor = UIColor.ElementColorDark.snowColor
        temperatureLabel.textColor = UIColor.ElementColorDark.snowColor
        humidityLabel.textColor = UIColor.ElementColorDark.snowColor
        pressureLabel.textColor = UIColor.ElementColorDark.snowColor
        windLabel.textColor = UIColor.ElementColorDark.snowColor
        textField.backgroundColor = UIColor.ElementColorDark.snowColor
        textField.textColor = UIColor.BackgroundColorDark.snowColor
        switchButton.tintColor = UIColor.ElementColor.thunderColor
//        shareButton.tintColor = UIColor.ElementColorDark.snowColor
        
        navigationController?.navigationBar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.ElementColorDark.snowColor
        navigationController?.toolbar.barTintColor = UIColor.NightSkyDark.nightSkyColor
        navigationController?.toolbar.tintColor = UIColor.BackgroundColorDark.snowColor
        forecastButton.tintColor = UIColor.ElementColorDark.snowColor
        
        StaticContext.currentUIcolor = UIColor.ElementColorDark.snowColor
    }
}
