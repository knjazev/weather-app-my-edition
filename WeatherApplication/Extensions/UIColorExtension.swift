//
//  UIColorExtension.swift
//  WeatherApplication
//
//  Created by UPIT on 24.08.21.
//

import UIKit

extension UIColor {
    struct ElementColor {
        static var sunColor: UIColor  { return UIColor(red: 255/255, green: 117/255, blue: 62/255, alpha: 1) }
        static var cloudColor: UIColor { return UIColor(red: 232/255, green: 182/255, blue: 182/255, alpha: 1)}
        static var rainColor: UIColor { return UIColor(red: 0/255, green: 218/255, blue: 255/255, alpha: 1) }
        static var thunderColor: UIColor { return UIColor(red: 248/255, green: 236/255, blue: 125/255, alpha: 1) }
        static var fogColor: UIColor { return UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)}
        static var snowColor: UIColor { return UIColor(red: 83/255, green: 100/255, blue: 135/255, alpha: 1) }
    }
    
    struct BackgroundColor {
        static var sunColor: UIColor  { return UIColor(red: 254/255, green: 202/255, blue: 202/255, alpha: 1) }
        static var cloudColor: UIColor { return UIColor(red: 6/255, green: 128/255, blue: 93/255, alpha: 1) }
        static var rainColor: UIColor { return UIColor(red: 11/255, green: 97/255, blue: 241/255, alpha: 1) }
        static var thunderColor: UIColor { return UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1) }
        static var fogColor: UIColor { return UIColor(red: 182/255, green: 182/255, blue: 183/255, alpha: 1) }
        static var snowColor: UIColor { return UIColor(red: 172/255, green: 217/255, blue: 242/255, alpha: 1) }
    }
    
    struct BackgroundColorDark {
        static var sunColor: UIColor  { return UIColor(red: 126/255, green: 100/255, blue: 100/255, alpha: 1) }
        static var cloudColor: UIColor { return UIColor(red: 2/255, green: 63/255, blue: 46/255, alpha: 1) }
        static var rainColor: UIColor { return UIColor(red: 5/255, green: 48/255, blue: 120/255, alpha: 1) }
        static var thunderColor: UIColor { return UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1) }
        static var fogColor: UIColor { return UIColor(red: 90/255, green: 90/255, blue: 91/255, alpha: 1) }
        static var snowColor: UIColor { return UIColor(red: 85/255, green: 108/255, blue: 120/255, alpha: 1) }
    }
    
    struct ElementColorDark {
        static var sunColor: UIColor  { return UIColor(red: 127/255, green: 58/255, blue: 30/255, alpha: 1) }
        static var cloudColor: UIColor { return UIColor(red: 126/255, green: 76/255, blue: 84/255, alpha: 1)}
        static var rainColor: UIColor { return UIColor(red: 0/255, green: 108/255, blue: 127/255, alpha: 1) }
        static var thunderColor: UIColor { return UIColor(red: 123/255, green: 117/255, blue: 62/255, alpha: 1) }
        static var fogColor: UIColor { return UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)}
        static var snowColor: UIColor { return UIColor(red: 40/255, green: 50/255, blue: 69/255, alpha: 1) }
    }
    struct NightSkyLight {
        static var nightSkyColor: UIColor  { return UIColor(red: 12/255, green: 28/255, blue: 52/255, alpha: 1) }
    }
    struct NightSkyDark {
        static var nightSkyColor: UIColor  { return UIColor(red: 7/255, green: 7/255, blue: 10/255, alpha: 1) }
    }
}
