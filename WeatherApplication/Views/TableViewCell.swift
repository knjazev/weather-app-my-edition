//
//  TableViewCell.swift
//  WeatherApplication
//
//  Created by UPIT on 11.08.21.
//

import UIKit
import Combine
import SnapKit

class TableViewCell: UITableViewCell {
    
    let dayLabel = UILabel()
    let tempLabel = UILabel()
    let monthLabel = UILabel()
    let imageLabel = UIImageView()
    let timeLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()

        addSubview(dayLabel)
        addSubview(tempLabel)
        addSubview(monthLabel)
        addSubview(imageLabel)
        addSubview(timeLabel)
        
        imageLabel.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(0)
            maker.width.equalTo(imageLabel.snp.height).multipliedBy(1.0/1.0)
        }
        
        tempLabel.font = UIFont(name: "Montserrat-Thin", size: 70)
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.snp.makeConstraints { maker in
            maker.right.equalTo(imageLabel).inset(100)
            maker.width.equalTo(imageLabel.snp.height).multipliedBy(1.0/1.0)
            maker.height.equalTo(100)
            maker.width.equalTo(100)
        }
        
        dayLabel.font = UIFont(name: "Montserrat-Medium", size: 50)
        dayLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.top.equalToSuperview().inset(10)
        }
        
        monthLabel.font = UIFont(name: "Montserrat-Thin", size: 30)
        monthLabel.snp.makeConstraints { maker in
            maker.left.equalTo(70)
            maker.top.equalToSuperview().inset(10)
        }
        
        timeLabel.font = UIFont(name: "Montserrat-Medium", size: 30)
        timeLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(monthLabel.snp.bottom).inset(-10)
            maker.left.equalTo(dayLabel.snp.left).inset(0)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
