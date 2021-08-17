//
//  TabBarController.swift
//  WeatherApplication
//
//  Created by UPIT on 16.08.21.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet weak var tabBarItems: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
          if item.tag == 1 {
            let newVC = self.storyboard?.instantiateViewController(withIdentifier:"tvc")
            newVC?.modalPresentationStyle = .automatic
            self.present(newVC!, animated: false, completion: nil)
        }
    }

}
