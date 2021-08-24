//
//  TableViewController.swift
//  WeatherApplication
//
//  Created by UPIT on 11.08.21.
//

import UIKit
import Combine

class TableViewController: UITableViewController {
    
    private let viewModel = ViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    var setOfDates = Set<String>()
    //    var number: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: WeatherAPI.currentUIcolor,
             NSAttributedString.Key.font: UIFont(name: "WhoopAss", size: 35)!]
        navigationController?.isToolbarHidden = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherAPI.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        switch WeatherAPI.trigger {
        case 0:
            subcribeAndUpdateUI(weather: viewModel.$currentWeather, cell: cell, indexPath: indexPath)
        case 1:
            subcribeAndUpdateUI(weather: viewModel.$currentWeather2, cell: cell, indexPath: indexPath)
        default:
            print("Default")
        }
        return cell
    }
    
    private func subcribeAndUpdateUI(weather: Published<WeatherDetail>.Publisher, cell: TableViewCell, indexPath: IndexPath) {
        weather
            .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] currentWeather in
                
                if WeatherAPI.isLightMode == true {
                    if let weatherConditionID = currentWeather.list?[indexPath.row].weather?[0].id {
                        cell.setLightStateUsingConditionID(id: weatherConditionID, cell: cell)
                    }
                } else if WeatherAPI.isLightMode == false {
                    if let weatherConditionID = currentWeather.list?[indexPath.row].weather?[0].id {
                        cell.setDarkStateUsingConditionID(id: weatherConditionID, cell: cell)
                    }
                }
                
                self?.title = currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : ""
                cell.dayLabel.text = currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[2] != nil ?
                    "\((currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[2])!)" : ""
                cell.monthLabel.text =
                    currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[1] != nil ?
                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[1])!)" : ""
                cell.timeLabel.text =
                    currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[1].components(separatedBy: ":")[0] != nil ?
                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[1].components(separatedBy: ":")[0] )!) :00" : ""
                cell.tempLabel.text = currentWeather.list?[indexPath.row].main?.temp != nil ? "\(Int((currentWeather.list?[indexPath.row].main?.temp!)!)) ºC" : " "
                cell.monthLabel.text = currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[1] != nil ?
                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[1])!)" : ""
            })
            .store(in: &cancellable)
    }
}

