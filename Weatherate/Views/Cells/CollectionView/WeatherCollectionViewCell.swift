//
//  WeatherCollectionViewCell.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit

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

}
