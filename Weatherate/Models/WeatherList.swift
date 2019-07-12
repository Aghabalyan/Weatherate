//
//  WeatherList.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/13/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper

class WeatherList: Mappable {
    
    var weather: [Weather]?
    var main: Main?
    var name: String?
    var coordinate: Coordinate?
    var date: Double?
    var day: Int?
    var hour: Int?

    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        weather <- map["weather"]
        main <- map["main"]
        name <- map["name"]
        coordinate <- map["coord"]
        date <- map["dt"]
        
        if let dt = self.date {
            let dateFormat = Date(timeIntervalSince1970: dt)
            let calendar = Calendar.current
            self.hour = calendar.component(.hour, from: dateFormat)
            self.day = calendar.component(.day, from: dateFormat)
        }
    }
}
