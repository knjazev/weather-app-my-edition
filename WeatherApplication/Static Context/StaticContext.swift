//
//  StaticContext.swift
//  WeatherApplication
//
//  Created by UPIT on 26.08.21.
//

import Foundation
import UIKit

class StaticContext {
    

static var shared = StaticContext()
    
static var trigger = 0 // fetch by city or coordinate
static var cityStatic = "Casablanca" // for home screen
static var coordinates = [0.0, 0.0] // for default
static var getLocationOnView = false // determines what kind of request on view now
static var currentUIcolor = UIColor.black // needs for tableView title
static var isLightMode = true //determines current mode on screen
static var currentCellTextColor = UIColor.ElementColor.rainColor // for section in a tableView
static var staticWeatherConditionID = 800

static var timeOfAday = "d"

    
static var arrayOfConditions = [Int]()
static var objectsArray = [Objects]()
static var sectionArray = [Objects]()
    
    func addLoader(view: UIViewController) {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        view.present(alert, animated: true, completion: nil)
    }
    
}

struct Objects: Hashable {
    var sectionName: String
    var sectionObjects: [String]
}
