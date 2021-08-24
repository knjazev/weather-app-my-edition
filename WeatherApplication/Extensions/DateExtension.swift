//
//  DateExtension.swift
//  WeatherApplication
//
//  Created by UPIT on 24.08.21.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
