//
//  Coordinate.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper

class Coordinate: Mappable {
    
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        latitude <- map["lat"]
        longitude <- map["lon"]
    }
}
