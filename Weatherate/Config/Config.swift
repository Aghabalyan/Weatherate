//
//  Config.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
struct Config {
    //https://api.openweathermap.org/data/2.5/weather

    static let ENVIRONMENT = "DEV"
    static let HOST_NAME = "openweathermap.org"
    static let BASE_URL = "https://api." + Config.HOST_NAME + "/data/2.5"
    static let API_TOKEN = ""
    static let API_VERSION = "v1"
    static let API_FORMAT = "json"
    static let DEBUG = true
}
