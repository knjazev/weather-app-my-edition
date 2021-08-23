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
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive

            if path.status == .satisfied {
                print("We're connected!")
                print("isReachable \(self?.isReachable)")
//                let ac = UIAlertController(title: "Good", message: "", preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
//                view.present(ac, animated: true)
            } else {
                print("No connection.")
                print("isReachable \(self?.isReachable)")
//                let ac = UIAlertController(title: "No internet connection", message: "", preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
//                view.present(ac, animated: true)
                
                
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
