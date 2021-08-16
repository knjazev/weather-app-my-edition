//
//  WeatherCell.swift
//  WeatherAppSwiftUI
//
//  Created by UPIT on 13.08.21.
//

import SwiftUI

struct WeatherCell: Identifiable {
    var id = UUID()
    var conditionImage: String
//    var time: String
    var state: String
    var temp: Int
    
//    var imageName: String { return breed }
}
