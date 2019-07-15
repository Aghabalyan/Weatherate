//
//  City.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/15/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper

class City: Mappable {

    var id: Int?
    var name: String?
    var country: String?
    var coord: Coordinate?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        country <- map["country"]
        coord <- map["coord"]
    }
}


