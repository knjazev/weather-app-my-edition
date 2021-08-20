//
//  APIError.swift
//  WeatherApplication
//
//  Created by UPIT on 6.08.21.
//

import Foundation


enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    case url
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - something went wrong"
        case .unknown:
            return "The error is unknown"
        case .url:
            return "Error with url"
        }
    }
}


