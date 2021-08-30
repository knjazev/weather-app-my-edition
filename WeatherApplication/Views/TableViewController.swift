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
        tableView.allowsSelection = false
        tableView.rowHeight = 100
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
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = StaticContext.currentUIcolor
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = StaticContext.currentCellTextColor
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        UpdateUI(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func UpdateUI(cell: TableViewCell, indexPath: IndexPath) {
        
        if StaticContext.isLightMode == true {
            switch StaticContext.timeOfAday {
            case "d":
                cell.setLightStateUsingConditionID(id: StaticContext.arrayOfConditions[indexPath.row], cell: cell)
            case "n":
                cell.setLightStateNightUsingConditionID(id: StaticContext.arrayOfConditions[indexPath.row], cell: cell)
            default:
                cell.setLightStateUsingConditionID(id: StaticContext.arrayOfConditions[indexPath.row], cell: cell)
            }
        }else if StaticContext.isLightMode == false {
            
            switch StaticContext.timeOfAday {
            case "d":
                cell.setDarkStateUsingConditionID(id: StaticContext.arrayOfConditions[indexPath.row], cell: cell)
            case "n":
                cell.setDarkStateNightUsingConditionID(id: StaticContext.arrayOfConditions[indexPath.row], cell: cell)
            default:
                cell.setDarkStateUsingConditionID(id: StaticContext.arrayOfConditions[indexPath.row], cell: cell)
            }
        }
        
       
        
        self.title = StaticContext.cityStatic
        
        cell.dayLabel.text =  StaticContext.sectionArray[indexPath.section].sectionObjects[indexPath.row]
        
    }
}

