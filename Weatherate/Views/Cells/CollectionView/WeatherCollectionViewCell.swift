//
//  WeatherCollectionViewCell.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit
import AlamofireImage

class WeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    // MARK: - Variables
    static let id = "weatherCell"
    static let name = "WeatherCollectionViewCell"
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var weatherTadayList: WeatherList? {
        didSet{
            guard let weatherList = weatherTadayList else { return }
            guard let weather = weatherList.weather, weather.count >= 1 else { return }
            guard let main = weatherList.main else { return }
    
            if let temp = main.temp {
                self.weatherLabel.text = "\(temp) º"
            }
            
            if let dt = weatherList.date {
                let date = Date(timeIntervalSince1970: dt)
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let day = calendar.component(.day, from: date)
                let currentDay = calendar.component(.day, from: Date())
                if day == currentDay {
                   dateLabel.text = "\(hour)h"
                }else {
                    dateLabel.text = "- -"
                }
                
                
            }
            
            if let hour = weatherList.hour {
                dateLabel.text = "\(hour)h"
            }
            
            if let icon = weather[0].icon {
                let url = URL(string: ("https://openweathermap.org/img/wn/\(icon)@2x.png"))
                imageView.af_setImage(withURL: url!, placeholderImage: nil, filter: nil, progress: nil, imageTransition: .crossDissolve(0.2)) { (response) in
                }
            }
        }
    }

}
