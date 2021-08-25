//
//  TVC.swift
//  WeatherApplication
//
//  Created by UPIT on 25.08.21.
//

import UIKit
import Combine

class TestTVC: UITableViewController {
    
   
    
//    var objectsArray = [Objects]()
    
    private let viewModel = ViewModel()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
//        viewModel.$currentWeather
//        .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] currentWeather in
//
//            WeatherAPI.numberOfSections = currentWeather.list?.count ?? 40
//
//        })
//        .store(in: &cancellable)
        
        return WeatherAPI.sectionArray.count
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.$currentWeather
//        .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] currentWeather in
//
//            for item in currentWeather.list ?? [] {
//                self?.objectsArray.append(Objects(sectionName: item.dtTxt?.components(separatedBy: " ")[0] ?? "huy", sectionObjects:  ["1","2","3","4"]))
//            }
//
//            WeatherAPI.numberOfSections = currentWeather.list?.count ?? 40
//
//        })
//        .store(in: &cancellable)
//
//        return WeatherAPI.numberOfSections
        
        return WeatherAPI.sectionArray[section].sectionObjects.count
    }
    
   
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return WeatherAPI.sectionArray[section].sectionName
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = WeatherAPI.sectionArray[indexPath.section].sectionObjects[indexPath.row]
        
        
        return cell
    }
    
    func update() -> [Objects]{
        
    viewModel.$currentWeather
        .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] currentWeather in
           
            for item in currentWeather.list ?? []{

                WeatherAPI.objectsArray.append(Objects(sectionName: item.dtTxt?.components(separatedBy: " ")[0] ?? "huy", sectionObjects:  ["1","2","3","4"]))
                
            }
//                ?.components(separatedBy: " ")[0].components(separatedBy: "-")[2] != nil ?
            //                    "\((currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[2])!)" : ""
            
//                self?.objectsArray = [
//                    Objects(sectionName: "Section 1", scetionObjects: ["1","2","3","4"]),
//                    Objects(sectionName: "Section 2", scetionObjects: ["1","2","7","4"]),
//                    Objects(sectionName: "Section 3", scetionObjects: ["1","2","3","4"]),
//                    Objects(sectionName: "Section 4", scetionObjects: ["1","2","3","4"]),
//                    Objects(sectionName: "Section 5", scetionObjects: ["1","2","3","4"]),
//                ]
            
//                self?.title = currentWeather.city?.name != nil ?
//                    "\((currentWeather.city?.name!)!)"
//                    : ""
            
            
//
//                cell.dayLabel.text = currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[2] != nil ?
//                    "\((currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[2])!)" : ""
//                cell.monthLabel.text =
//                    currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[1] != nil ?
//                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[1])!)" : ""
//                cell.timeLabel.text =
//                    currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[1].components(separatedBy: ":")[0] != nil ?
//                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[1].components(separatedBy: ":")[0] )!) :00" : ""
//                cell.tempLabel.text = currentWeather.list?[indexPath.row].main?.temp != nil ? "\(Int((currentWeather.list?[indexPath.row].main?.temp!)!)) ºC" : " "
//                cell.monthLabel.text = currentWeather.list?[indexPath.row].dtTxt?.components(separatedBy: " ")[0].components(separatedBy: "-")[1] != nil ?
//                    "\(( currentWeather.list?[indexPath.row].dtTxt!.components(separatedBy: " ")[0].components(separatedBy: "-")[1])!)" : ""
        })
        .store(in: &cancellable)
    
    
        return WeatherAPI.objectsArray
        
    }
    
}
