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
    var isReachableOnWiFi: Bool = true

    func startMonitoring(view: UIViewController) {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
           
            if path.status == .satisfied{

            }else {
                DispatchQueue.main.async {
                let ac = UIAlertController(title: "No internet connection", message: "", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Refresh", style: .default, handler: { action in

                    self?.startMonitoring(view: view)

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
