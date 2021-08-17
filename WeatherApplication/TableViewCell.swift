//
//  TableViewCell.swift
//  WeatherApplication
//
//  Created by UPIT on 11.08.21.
//

import UIKit
import Combine

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    private let viewModel = ViewModel()
  
    private var cancellable = Set<AnyCancellable>()

    override func awakeFromNib() {
        super.awakeFromNib()
//
//        viewModel.$currentWeather
//            .sink(receiveValue: {[weak self] currentWeather in
//
//                self?.cityLabel.text =
//                    currentWeather.city?.name != nil ?
//                    "\((currentWeather.city?.name!)!)"
//                    : ""
//
//                self?.tempLabel.text =
//                    currentWeather.list?[0].main?.temp != nil ?
//                    "\(Int((currentWeather.list?[0].main?.temp!)!)) ºC"
//                    : " "
//
//                self?.humidityLabel.text =
//                    currentWeather.list?[0].main?.humidity != nil ?
//                    "\(Int((currentWeather.list?[0].main?.humidity!)!)) %"
//                    : " "
//
//                self?.pressureLabel.text =
//                    currentWeather.list?[0].main?.pressure != nil ?
//                    "\(Int((currentWeather.list?[0].main?.pressure!)!)) hPa"
//                    : " "
//
//
//                self?.imageLabel.image = UIImage(systemName: self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800) ?? "sun.max")
//
//                //                self?.jsonName = self?.viewModel.getweatherConditionName(weatherConditionID: currentWeather.list?[0].weather?[0].id! ?? 800) ?? "sun.max"
//
//
//
//                //                self?.playAnimation()
//
//            }
//            )
//            .store(in: &cancellable)
//    }
//
//
   
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
