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
//              tabBar.backgroundColor = .black
//               tabBar.tintColor = .black
                tabBar.barTintColor = .black

    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        

        
          if item.tag == 0 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"vc") as? ViewController
            let tvc = self.storyboard?.instantiateViewController(withIdentifier:"tvc") as? TableViewController
            
            print(vc?.traitCollection.userInterfaceStyle.rawValue)
            
            
            
            tvc?.modalPresentationStyle = .automatic
            self.present(tvc!, animated: false, completion: nil)
            

            if vc?.traitCollection.userInterfaceStyle == .light {
               print("hello")
            }else if vc?.traitCollection.userInterfaceStyle == .dark {
                print("fuck")
              
            }
            
        }
    }

}
