//
//  Settings.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import CoreLocation

struct Settings {

    enum YEREVAN: Double {
        case latitude = 40.178576
        case longitude = 44.511739
    }
    
    struct Weather {
        static let ApiKey: String = "7c87eda9029133befcf19135847b37d4"
    }
    
    enum WeatherType: String {
        case Metric = "metric"
        case Imperial = "imperial"
    }
    
}
