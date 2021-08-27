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
        addSubview(imageLabel)
        
        imageLabel.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(0)
            maker.width.equalTo(imageLabel.snp.height).multipliedBy(1.0/1.0)
            maker.height.equalTo(100)
            maker.width.equalTo(100)
        }
        
        dayLabel.font = UIFont(name: "Montserrat-Medium", size: 50)
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.right.equalToSuperview().inset(110)
            maker.centerY.equalToSuperview()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
