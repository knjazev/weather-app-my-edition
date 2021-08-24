//
//  Extensions.swift
//  WeatherApplication
//
//  Created by UPIT on 23.08.21.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}

// With errors
//extension UITextField {
//    var textPublisher: AnyPublisher<String, APIError> {
//        NotificationCenter.default
//            .publisher(for: UITextField.textDidChangeNotification, object: self)
//            .compactMap { $0.object as? UITextField }
//            .setFailureType(to: APIError.self)
//            .map { $0.text ?? "" }
//            .eraseToAnyPublisher()
//    }
//}


