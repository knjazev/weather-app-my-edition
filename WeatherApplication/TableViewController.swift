//
//  TableViewController.swift
//  WeatherApplication
//
//  Created by UPIT on 11.08.21.
//

import UIKit
import Combine

class TableViewController: UITableViewController, UITabBarDelegate {
    
    private let viewModel = ViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    var setOfDates = Set<String>()
    var number = 0
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tableView.reloadData()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
       
       print("viewWillAppear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        viewModel.$currentWeather
            .sink(receiveValue: { [weak self] currentWeather in
                self?.title = currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : ""
            })
            .store(in: &cancellable)
        
    }

  
//
    
    
//        override func numberOfSections(in tableView: UITableView) -> Int {
//            viewModel.$currentWeather
//                .sink(receiveValue: { [weak self] currentWeather in
//
                    
//
//                    self?.number = currentWeather.list?.count ?? 0
//                    print("khkjhkj r \(currentWeather.list?.count)")
//
//                    if let array = currentWeather.list {
//
//                        for date in array {
//                            var stringDate = date.dtTxt
//                            stringDate = stringDate?.components(separatedBy: " ")[0]
//
//                            self?.setOfDates.insert(stringDate!)
//                        }
//                    }

//                    for date in currentWeather.list != nil ?? [] {
//                        var stringDate = date.dtTxt
//                        stringDate = stringDate?.components(separatedBy: " ")[0]

//                    }
//
//                }
//                )
//                .store(in: &cancellable)
//
//            print(number)
//
//            return number
//        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.$currentWeather
            .sink(receiveValue: { [weak self] currentWeather in
                self?.number = currentWeather.list?.count ?? 0
            })
            .store(in: &cancellable)
        return 40
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        viewModel.$currentWeather
            .sink(receiveValue: {[weak self] currentWeather in

                cell.cityLabel.text =
                    currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0] != nil ?
                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0])!)"
                    : ""
                
                cell.timeLabel.text =
                    currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[1] != nil ?
                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[1])!)"
                    : ""
                
                cell.tempLabel.text =
                    currentWeather.list?[indexPath.row].main?.temp != nil ?
                    "\(Int((currentWeather.list?[indexPath.row].main?.temp!)!)) ºC"
                    : " "
                
                cell.humidityLabel.text =
                    currentWeather.list?[indexPath.row].main?.humidity != nil ?
                    "\(Int((currentWeather.list?[indexPath.row].main?.humidity!)!)) %"
                    : " "
                
                cell.pressureLabel.text =
                    currentWeather.list?[indexPath.row].main?.pressure != nil ?
                    "\(Int((currentWeather.list?[indexPath.row].main?.pressure!)!)) hPa"
                    : " "
                
                cell.imageLabel.image = UIImage(systemName: self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[indexPath.row].weather?[0].id! ?? 800) ?? "sun.max")
                

                
           
            }
            )
            .store(in: &cancellable)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       let array = Array(setOfDates)
        if section < array.count {
            
            
            return array[section]
        }

        return nil
    }
}
