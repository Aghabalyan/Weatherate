//
//  Main.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper

class Main: Mappable {
    
    var temp: Int?
    var pressure: Double?
    var humidity: Double?
    var tempMin: Double?
    var tempMax: Double?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        tempMin <- map["temp_min"]
        tempMax <- map["temp_max"]
    }
}
