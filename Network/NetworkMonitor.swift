//
//  NetworkMonitor.swift
//  WeatherApplication
//
//  Created by UPIT on 23.08.21.
//

import Foundation
import UIKit
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool {
        status == .satisfied
    }
    var isReachableOnCellular: Bool = true

    func startMonitoring(view: UIViewController) {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
           
            if path.status == .satisfied{

               
            } else {
                DispatchQueue.main.async {
                let ac = UIAlertController(title: "No internet connection", message: "", preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))

                ac.addAction(UIAlertAction(title: "Refresh", style: .default, handler: { action in

                    self?.startMonitoring(view: view)

                    
                    
//                    if let bundleIdentifier = Bundle.main.bundleIdentifier, let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
//                        if UIApplication.shared.canOpenURL(appSettings) {
//                            UIApplication.shared.open(appSettings)
//                        }
//                    }
                }))
                view.present(ac, animated: true)
                }
            }
            print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
