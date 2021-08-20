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
    var number: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100
        
        
        //        if traitCollection.userInterfaceStyle == .dark {
        //            switchLabel.selectedSegmentIndex = 1
        //            weatherConditionImage.tintColor = .white
        //        }else if (traitCollection.userInterfaceStyle == .light) {
        //            switchLabel.selectedSegmentIndex = 0
        //            weatherConditionImage.tintColor = .black
        //        }else if (traitCollection.userInterfaceStyle == .unspecified) {
        //            switchLabel.selectedSegmentIndex = 0
        //            weatherConditionImage.tintColor = .black
        //        }
        
        
        viewModel.$currentWeather
            .sink(receiveValue: { [weak self] currentWeather in
                self?.title = currentWeather.city?.name != nil ?
                    "\((currentWeather.city?.name!)!)"
                    : ""
            })
            .store(in: &cancellable)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherAPI.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        switch WeatherAPI.trigger {
      
        case 0:
            viewModel.$currentWeather
                .sink(receiveValue: {[weak self] currentWeather in
                    print("case 0 \(WeatherAPI.trigger)")
                    
                    if let weatherConditionID = currentWeather.list?[indexPath.row].weather?[0].id {
                        
                        switch weatherConditionID {
                        case 200...232:
                            cell.backgroundColor = UIColor.BackgroundColor.thunderColor
                            cell.tempLabel.textColor = UIColor.ElementColor.thunderColor
                            cell.dayLabel.textColor = UIColor.ElementColor.thunderColor
                            cell.monthLabel.textColor = UIColor.ElementColor.thunderColor
                            cell.timeLabel.textColor = UIColor.ElementColor.thunderColor
                        case 300...321:
                            cell.backgroundColor = UIColor.BackgroundColor.rainColor
                            cell.tempLabel.textColor = UIColor.ElementColor.rainColor
                            cell.dayLabel.textColor = UIColor.ElementColor.rainColor
                            cell.monthLabel.textColor = UIColor.ElementColor.rainColor
                            cell.timeLabel.textColor = UIColor.ElementColor.rainColor
                        case 500...531:
                            cell.backgroundColor = UIColor.BackgroundColor.rainColor
                            cell.tempLabel.textColor = UIColor.ElementColor.rainColor
                            cell.dayLabel.textColor = UIColor.ElementColor.rainColor
                            cell.monthLabel.textColor = UIColor.ElementColor.rainColor
                            cell.timeLabel.textColor = UIColor.ElementColor.rainColor
                        case 600...622:
                            cell.backgroundColor = UIColor.BackgroundColor.snowColor
                            cell.tempLabel.textColor = UIColor.ElementColor.snowColor
                            cell.dayLabel.textColor = UIColor.ElementColor.snowColor
                            cell.monthLabel.textColor = UIColor.ElementColor.snowColor
                            cell.timeLabel.textColor = UIColor.ElementColor.snowColor
                        case 701...781:
                            cell.backgroundColor = UIColor.BackgroundColor.fogColor
                            cell.tempLabel.textColor = UIColor.ElementColor.fogColor
                            cell.dayLabel.textColor = UIColor.ElementColor.fogColor
                            cell.monthLabel.textColor = UIColor.ElementColor.fogColor
                            cell.timeLabel.textColor = UIColor.ElementColor.fogColor
                        case 800:
                            cell.backgroundColor = UIColor.BackgroundColor.sunColor
                            cell.tempLabel.textColor = UIColor.ElementColor.sunColor
                            cell.dayLabel.textColor = UIColor.ElementColor.sunColor
                            cell.monthLabel.textColor = UIColor.ElementColor.sunColor
                            cell.timeLabel.textColor = UIColor.ElementColor.sunColor
                        case 801...804:
                            cell.backgroundColor = UIColor.BackgroundColor.cloudColor
                            cell.tempLabel.textColor = UIColor.ElementColor.cloudColor
                            cell.dayLabel.textColor = UIColor.ElementColor.cloudColor
                            cell.monthLabel.textColor = UIColor.ElementColor.cloudColor
                            cell.timeLabel.textColor = UIColor.ElementColor.cloudColor
                        default:
                            return cell.backgroundColor = UIColor.BackgroundColor.cloudColor
                        }
                        
                    }
                    
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
                    
                    cell.imageLabel.image = UIImage(named: self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[indexPath.row].weather?[0].id! ?? 800) ?? "sun.max")
                })
                .store(in: &cancellable)
            
        case 1:
            viewModel.$currentWeather2
                .sink(receiveValue: {[weak self] currentWeather in
                    
                    if let weatherConditionID = currentWeather.list?[indexPath.row].weather?[0].id {
                        
                        switch weatherConditionID {
                        case 200...232:
                            cell.backgroundColor = UIColor.BackgroundColor.thunderColor
                            cell.tempLabel.textColor = UIColor.ElementColor.thunderColor
                            cell.dayLabel.textColor = UIColor.ElementColor.thunderColor
                            cell.monthLabel.textColor = UIColor.ElementColor.thunderColor
                            cell.timeLabel.textColor = UIColor.ElementColor.thunderColor
                        case 300...321:
                            cell.backgroundColor = UIColor.BackgroundColor.rainColor
                            cell.tempLabel.textColor = UIColor.ElementColor.rainColor
                            cell.dayLabel.textColor = UIColor.ElementColor.rainColor
                            cell.monthLabel.textColor = UIColor.ElementColor.rainColor
                            cell.timeLabel.textColor = UIColor.ElementColor.rainColor
                        case 500...531:
                            cell.backgroundColor = UIColor.BackgroundColor.rainColor
                            cell.tempLabel.textColor = UIColor.ElementColor.rainColor
                            cell.dayLabel.textColor = UIColor.ElementColor.rainColor
                            cell.monthLabel.textColor = UIColor.ElementColor.rainColor
                            cell.timeLabel.textColor = UIColor.ElementColor.rainColor
                        case 600...622:
                            cell.backgroundColor = UIColor.BackgroundColor.snowColor
                            cell.tempLabel.textColor = UIColor.ElementColor.snowColor
                            cell.dayLabel.textColor = UIColor.ElementColor.snowColor
                            cell.monthLabel.textColor = UIColor.ElementColor.snowColor
                            cell.timeLabel.textColor = UIColor.ElementColor.snowColor
                        case 701...781:
                            cell.backgroundColor = UIColor.BackgroundColor.fogColor
                            cell.tempLabel.textColor = UIColor.ElementColor.fogColor
                            cell.dayLabel.textColor = UIColor.ElementColor.fogColor
                            cell.monthLabel.textColor = UIColor.ElementColor.fogColor
                            cell.timeLabel.textColor = UIColor.ElementColor.fogColor
                        case 800:
                            cell.backgroundColor = UIColor.BackgroundColor.sunColor
                            cell.tempLabel.textColor = UIColor.ElementColor.sunColor
                            cell.dayLabel.textColor = UIColor.ElementColor.sunColor
                            cell.monthLabel.textColor = UIColor.ElementColor.sunColor
                            cell.timeLabel.textColor = UIColor.ElementColor.sunColor
                        case 801...804:
                            cell.backgroundColor = UIColor.BackgroundColor.cloudColor
                            cell.tempLabel.textColor = UIColor.ElementColor.cloudColor
                            cell.dayLabel.textColor = UIColor.ElementColor.cloudColor
                            cell.monthLabel.textColor = UIColor.ElementColor.cloudColor
                            cell.timeLabel.textColor = UIColor.ElementColor.cloudColor
                        default:
                            return cell.backgroundColor = UIColor.BackgroundColor.cloudColor
                        }
                        
                    }
                    
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
                    
                    cell.imageLabel.image = UIImage(named: self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[indexPath.row].weather?[0].id! ?? 800) ?? "sun.max")
                })
                .store(in: &cancellable)
            
        default:
            print("Default")
        }
        return cell
    }
}
