//
//  ResultState.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//


import Foundation

enum resultState {
    case loading
    case success(content: [WeatherDetail])
    case failed(error: Error)
}
