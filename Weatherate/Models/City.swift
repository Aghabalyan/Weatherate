//
//  City.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper

class City: Mappable {
    
    var id: Int?
    var name: String?
    var coordinate: Coordinate?
    var country: String?
    var population: Int?
    var timezone: Int?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        coordinate <- map["coor"]
        country <- map["country"]
        population <- map["population"]
        timezone <- map["timezone"]
    }
}
