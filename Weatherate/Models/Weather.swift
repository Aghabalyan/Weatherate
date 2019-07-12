//
//  Weather.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper

class WeatherForm: Mappable {
    
    var lat: Double?
    var lon: Double?
    var appid: String?
    var units: String?
    
    init(lat: Double, lon: Double, appid: String, units: String) {
        self.lat = lat
        self.lon = lon
        self.appid = appid
        self.units = units
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
        appid <- map["appid"]
        units <- map["units"]
    }
}

class WeatherResponse: Mappable {
    
    var weathersList: [WeatherList]?
    var weather: [Weather]?
    var main: Main?
    var name: String?
    var coordinate: Coordinate?
    var date: Double?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        
        weather <- map["weather"]
        main <- map["main"]
        name <- map["name"]
        coordinate <- map["coord"]
        date <- map["dt"]
        
        weathersList <- map["list"]
    }
}

class Weather: Mappable {
    
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}

enum WeatherResponseData<WeatherResponse> {
    case success(results: WeatherResponse)
    case base(response: BaseResponse)
    case isOffline
}
