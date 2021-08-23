//
//  TabBarController.swift
//  WeatherApplication
//
//  Created by UPIT on 16.08.21.
//

import UIKit
import Reachability

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let reachability = try! Reachability()
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }

        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
          if item.tag == 0 {
            
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"vc") as? ViewController
            
//            vc?.navigationController?.isNavigationBarHidden = true
//            let tvc = self.storyboard?.instantiateViewController(withIdentifier:"tvc") as? TableViewController
            
//            navigationController?.popToViewController(tvc!, animated: true)

//            tvc?.modalPresentationStyle = .popover

//            self.present(tvc!, animated: false, completion: nil)
            
        }
    }

}
