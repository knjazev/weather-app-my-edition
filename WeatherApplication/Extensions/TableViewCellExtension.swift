//
//  TableViewCellExtension.swift
//  WeatherApplication
//
//  Created by UPIT on 24.08.21.
//

import UIKit

extension TableViewCell {
    func setLightStateUsingConditionID(id: Int, cell: TableViewCell) {
        switch id {
        case 200...232:
            cell.backgroundColor = UIColor.BackgroundColor.thunderColor
            cell.tempLabel.textColor = UIColor.ElementColor.thunderColor
            cell.dayLabel.textColor = UIColor.ElementColor.thunderColor
            cell.monthLabel.textColor = UIColor.ElementColor.thunderColor
            cell.timeLabel.textColor = UIColor.ElementColor.thunderColor
            cell.imageLabel.image = UIImage(named: "cloud.bolt")
            
            
        case 300...321, 500...531:
            cell.backgroundColor = UIColor.BackgroundColor.rainColor
            cell.tempLabel.textColor = UIColor.ElementColor.rainColor
            cell.dayLabel.textColor = UIColor.ElementColor.rainColor
            cell.monthLabel.textColor = UIColor.ElementColor.rainColor
            cell.timeLabel.textColor = UIColor.ElementColor.rainColor
            cell.imageLabel.image = UIImage(named: "cloud.rain")
        case 600...622:
            cell.backgroundColor = UIColor.BackgroundColor.snowColor
            cell.tempLabel.textColor = UIColor.ElementColor.snowColor
            cell.dayLabel.textColor = UIColor.ElementColor.snowColor
            cell.monthLabel.textColor = UIColor.ElementColor.snowColor
            cell.timeLabel.textColor = UIColor.ElementColor.snowColor
            cell.imageLabel.image = UIImage(named: "cloud.snow")
        case 701...781:
            cell.backgroundColor = UIColor.BackgroundColor.fogColor
            cell.tempLabel.textColor = UIColor.ElementColor.fogColor
            cell.dayLabel.textColor = UIColor.ElementColor.fogColor
            cell.monthLabel.textColor = UIColor.ElementColor.fogColor
            cell.timeLabel.textColor = UIColor.ElementColor.fogColor
            cell.imageLabel.image = UIImage(named: "cloud.fog")
        case 800:
            cell.backgroundColor = UIColor.BackgroundColor.sunColor
            cell.tempLabel.textColor = UIColor.ElementColor.sunColor
            cell.dayLabel.textColor = UIColor.ElementColor.sunColor
            cell.monthLabel.textColor = UIColor.ElementColor.sunColor
            cell.timeLabel.textColor = UIColor.ElementColor.sunColor
            cell.imageLabel.image = UIImage(named: "sun.max")
        case 801...804:
            cell.backgroundColor = UIColor.BackgroundColor.cloudColor
            cell.tempLabel.textColor = UIColor.ElementColor.cloudColor
            cell.dayLabel.textColor = UIColor.ElementColor.cloudColor
            cell.monthLabel.textColor = UIColor.ElementColor.cloudColor
            cell.timeLabel.textColor = UIColor.ElementColor.cloudColor
            cell.imageLabel.image = UIImage(named: "cloud")
            
        default:
            cell.backgroundColor = UIColor.BackgroundColor.rainColor
            cell.tempLabel.textColor = UIColor.ElementColor.rainColor
            cell.dayLabel.textColor = UIColor.ElementColor.rainColor
            cell.monthLabel.textColor = UIColor.ElementColor.rainColor
            cell.timeLabel.textColor = UIColor.ElementColor.rainColor
            cell.imageLabel.image = UIImage(named: "cloud.rain")
        }
    }
    
    func setDarkStateUsingConditionID(id: Int,cell: TableViewCell) {
        switch id {
        case 200...232:
            cell.backgroundColor = UIColor.BackgroundColorDark.thunderColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.thunderColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.thunderColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.thunderColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.thunderColor
            cell.imageLabel.image = UIImage(named: "cloud.bolt.dark")
        case 300...321, 500...531:
            cell.backgroundColor = UIColor.BackgroundColorDark.rainColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.imageLabel.image = UIImage(named: "cloud.rain.dark")
        case 600...622:
            cell.backgroundColor = UIColor.BackgroundColorDark.snowColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.snowColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.snowColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.snowColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.snowColor
            cell.imageLabel.image = UIImage(named: "cloud.snow.dark")
        case 701...781:
            cell.backgroundColor = UIColor.BackgroundColorDark.fogColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.fogColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.fogColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.fogColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.fogColor
            cell.imageLabel.image = UIImage(named: "cloud.fog.dark")
        case 800:
            cell.backgroundColor = UIColor.BackgroundColorDark.sunColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.sunColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.sunColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.sunColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.sunColor
            cell.imageLabel.image = UIImage(named: "sun.max.dark")
        case 801...804:
            cell.backgroundColor = UIColor.BackgroundColorDark.cloudColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.cloudColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.cloudColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.cloudColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.cloudColor
            cell.imageLabel.image?.withTintColor(UIColor.ElementColorDark.cloudColor)
            cell.imageLabel.image = UIImage(named: "cloud.dark")
        default:
            cell.backgroundColor = UIColor.BackgroundColorDark.rainColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.rainColor
        }
    }
    
    func setLightStateNightUsingConditionID(id: Int, cell: TableViewCell) {
        switch id {
        case 200...232:
            cell.backgroundColor = UIColor.NightSkyLight.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColor.thunderColor
            cell.dayLabel.textColor = UIColor.ElementColor.thunderColor
            cell.monthLabel.textColor = UIColor.ElementColor.thunderColor
            cell.timeLabel.textColor = UIColor.ElementColor.thunderColor
            cell.imageLabel.image = UIImage(named: "night.cloud.bolt")
            
            
        case 300...321, 500...531:
            cell.backgroundColor = UIColor.NightSkyLight.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColor.rainColor
            cell.dayLabel.textColor = UIColor.ElementColor.rainColor
            cell.monthLabel.textColor = UIColor.ElementColor.rainColor
            cell.timeLabel.textColor = UIColor.ElementColor.rainColor
            cell.imageLabel.image = UIImage(named: "night.cloud.rain")
        case 600...622:
            cell.backgroundColor = UIColor.NightSkyLight.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColor.snowColor
            cell.dayLabel.textColor = UIColor.ElementColor.snowColor
            cell.monthLabel.textColor = UIColor.ElementColor.snowColor
            cell.timeLabel.textColor = UIColor.ElementColor.snowColor
            cell.imageLabel.image = UIImage(named: "night.cloud.snow")
        case 701...781:
            cell.backgroundColor = UIColor.NightSkyLight.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColor.fogColor
            cell.dayLabel.textColor = UIColor.ElementColor.fogColor
            cell.monthLabel.textColor = UIColor.ElementColor.fogColor
            cell.timeLabel.textColor = UIColor.ElementColor.fogColor
            cell.imageLabel.image = UIImage(named: "night.cloud.fog")
        case 800:
            cell.backgroundColor = UIColor.NightSkyLight.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColor.sunColor
            cell.dayLabel.textColor = UIColor.ElementColor.sunColor
            cell.monthLabel.textColor = UIColor.ElementColor.sunColor
            cell.timeLabel.textColor = UIColor.ElementColor.sunColor
            cell.imageLabel.image = UIImage(named: "night.sun.max")
        case 801...804:
            cell.backgroundColor = UIColor.NightSkyLight.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColor.cloudColor
            cell.dayLabel.textColor = UIColor.ElementColor.cloudColor
            cell.monthLabel.textColor = UIColor.ElementColor.cloudColor
            cell.timeLabel.textColor = UIColor.ElementColor.cloudColor
            cell.imageLabel.image = UIImage(named: "night.cloud")
            
        default:
            cell.backgroundColor = UIColor.NightSkyLight.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColor.rainColor
            cell.dayLabel.textColor = UIColor.ElementColor.rainColor
            cell.monthLabel.textColor = UIColor.ElementColor.rainColor
            cell.timeLabel.textColor = UIColor.ElementColor.rainColor
            cell.imageLabel.image = UIImage(named: "night.cloud.rain")
        }
    }
    
    func setDarkStateNightUsingConditionID(id: Int,cell: TableViewCell) {
        switch id {
        case 200...232:
            cell.backgroundColor = UIColor.NightSkyDark.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.thunderColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.thunderColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.thunderColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.thunderColor
            cell.imageLabel.image = UIImage(named: "night.cloud.bolt.dark")
        case 300...321, 500...531:
            cell.backgroundColor = UIColor.NightSkyDark.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.imageLabel.image = UIImage(named: "night.cloud.rain.dark")
        case 600...622:
            cell.backgroundColor = UIColor.NightSkyDark.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.snowColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.snowColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.snowColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.snowColor
            cell.imageLabel.image = UIImage(named: "night.cloud.snow.dark")
        case 701...781:
            cell.backgroundColor = UIColor.NightSkyDark.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.fogColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.fogColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.fogColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.fogColor
            cell.imageLabel.image = UIImage(named: "night.cloud.fog.dark")
        case 800:
            cell.backgroundColor = UIColor.NightSkyDark.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.sunColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.sunColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.sunColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.sunColor
            cell.imageLabel.image = UIImage(named: "night.sun.max.dark")
        case 801...804:
            cell.backgroundColor = UIColor.NightSkyDark.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.cloudColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.cloudColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.cloudColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.cloudColor
            cell.imageLabel.image?.withTintColor(UIColor.ElementColorDark.cloudColor)
            cell.imageLabel.image = UIImage(named: "night.cloud.dark")
        default:
            cell.backgroundColor = UIColor.NightSkyDark.nightSkyColor
            cell.tempLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.dayLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.monthLabel.textColor = UIColor.ElementColorDark.rainColor
            cell.timeLabel.textColor = UIColor.ElementColorDark.rainColor
        }
    }
    
}

