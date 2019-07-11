//
//  Weather.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper

class WeatherForm: Mappable {
    
    var results: Int?
    
    init(results: Int) {
        self.results = results
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
}

class WeatherResponse: Mappable {
    
    var results: [Weather]?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
}

class Weather: Mappable {
    
    var userId: String?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        userId <- map["id.value"]
    }
}

enum WeatherResponseData<WeatherResponse> {
    case success(results: WeatherResponse)
    case base(response: BaseResponse)
    case isOffline
}
