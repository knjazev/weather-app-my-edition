//
//  TestTableViewController.swift
//  WeatherApplication
//
//  Created by UPIT on 28.08.21.
//

import UIKit

class TestTableViewController: UITableViewController {
//    var placeholderTableView: TableView
    var array = [String]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        placeholderTableView = tableView as? TableView
//        placeholderTableView?.placeholderDelegate = self
        
      
        tableView.backgroundColor = .black
        
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.array.append("\(Int.random(in: (0...20)))")
            self.array.append("\(Int.random(in: (0...20)))")
            self.array.append("\(Int.random(in: (0...20)))")
            self.array.append("\(Int.random(in: (0...20)))")
            self.array.append("\(Int.random(in: (0...20)))")
            
          
        
            self.tableView.reloadData()
            
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = array[indexPath.row]

        return cell
    }
    




}
