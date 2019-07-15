//
//  SearchTableViewCell.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/15/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var city: City? {
        didSet{
            guard let city = city else { return }
            if let name = city.name, let country = city.country {
                nameLabel.text = name + "," + country
            }
        }
    }
}
