//
//  TVC.swift
//  WeatherApplication
//
//  Created by UPIT on 25.08.21.
//

import UIKit
import Combine

class TableViewController: UITableViewController {
    private let viewModel = ViewModel()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        tableView.sectionIndexColor = .yellow
        tableView.sectionIndexBackgroundColor = .yellow
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: StaticContext.currentUIcolor,
             NSAttributedString.Key.font: UIFont(name: "WhoopAss", size: 35)!]
        navigationController?.isToolbarHidden = true
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return StaticContext.sectionArray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaticContext.sectionArray[section].sectionObjects.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: StaticContext.sectionArray[section].sectionName)
        let currentTitle = date?.getFormattedDate(format: "dd MMMM")
        return currentTitle
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.backgroundColor = UIColor.ElementColor.cloudColor
        cell.dayLabel.textColor = UIColor.ElementColorDark.cloudColor

        
        switch StaticContext.trigger {
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
                if StaticContext.isLightMode == true {
                    if let weatherConditionID = currentWeather.list?[indexPath.row].weather?[0].id {
                        cell.setLightStateUsingConditionID(id: weatherConditionID, cell: cell)
                    }
                } else if StaticContext.isLightMode == false {
                    if let weatherConditionID = currentWeather.list?[indexPath.row].weather?[0].id {
                        cell.setDarkStateUsingConditionID(id: weatherConditionID, cell: cell)
                    }
                }
                
                self?.title = currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : ""
                
//                cell.dayLabel.text = currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[2] != nil ?
//                    "\((currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[2])!)" : ""
//                cell.monthLabel.text =
//                    currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[1] != nil ?
//                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[1])!)" : ""
//                cell.timeLabel.text =
//                    currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[1].components(separatedBy: ":")[0] != nil ?
//                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[1].components(separatedBy: ":")[0] )!) :00" : ""
                
                cell.dayLabel.text =  StaticContext.sectionArray[indexPath.section].sectionObjects[indexPath.row]
                
                
                
//                cell.tempLabel.text = currentWeather.list?[indexPath.row].main?.temp != nil ? "\(Int((currentWeather.list?[indexPath.row].main?.temp!)!)) ºC" : " "
//                cell.monthLabel.text = currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[1] != nil ?
//                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[1])!)" : ""
            })
            .store(in: &cancellable)
        
      
    }
}
