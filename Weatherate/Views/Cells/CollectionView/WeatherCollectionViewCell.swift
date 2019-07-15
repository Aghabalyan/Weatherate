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
    var isNextDays = false
    
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
                self.weatherLabel.text = "\(Int(temp)) º"
            }
            
            if let hour = weatherList.hour, let month = weatherList.month, let day = weatherList.day {
                dateLabel.text = isNextDays ? "\(month)/\(day)" : "\(hour)h"
            }else {
                dateLabel.text = "- -"
            }
            
            if let icon = weather[0].icon {
                let url = URL(string: ("https://openweathermap.org/img/wn/\(icon)@2x.png"))
                imageView.af_setImage(withURL: url!, placeholderImage: nil, filter: nil, progress: nil, imageTransition: .crossDissolve(0.2)) { (response) in
                }
            }
        }
    }
}
