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
    var dtTxt: String?
    var date: Double?
    var day: Int?
    var hour: Int?
    var month: Int?

    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        weather <- map["weather"]
        main <- map["main"]
        name <- map["name"]
        coordinate <- map["coord"]
        dtTxt <- map["dt_txt"]
        date <- map["dt"]
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.hour = Int(DateFormattingHelper.stringFrom(date: dateFormatterGet.date(from: dtTxt!), format: .hour))
        self.day = Int(DateFormattingHelper.stringFrom(date: dateFormatterGet.date(from: dtTxt!), format: .day))
        self.month = Int(DateFormattingHelper.stringFrom(date: dateFormatterGet.date(from: dtTxt!), format: .month))
    }
}
