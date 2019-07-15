//
//  WeatherService.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class WeatherService {
    
    static let shered = WeatherService()
    
    func weatherResponse(appid: String, lat: Double, lon: Double, units: String, completion: @escaping ((WeatherResponseData<WeatherResponse>) -> Void)) {
        BaseService.shared.post(endpoint: "/weather?appid=\(appid)&lat=\(lat)&lon=\(lon)&units=\(units)", object: [:], for: .unsecure)
            .responseString { (response) in
                //print(response.result.value ?? "result value is nil")
                if let responseHttp = response.response, let value = response.result.value {
                    if let baseResponse = BaseService.shared.checkBaseResponse(responseHttp, value) {
                        return completion(.base(response: baseResponse))
                    }
                } else {
                    return completion(.isOffline)
                }
                switch response.response?.statusCode ?? 400 {
                case 200:
                    if let value = response.result.value, let data = Mapper<WeatherResponse>().map(JSONString: value) {
                        return completion(.success(results: data))
                    }
                    return completion(.base(response: .unexpectedError(error: ResponseUnexpectedError.mappingFailed)))
                default:
                    return completion(.base(response: .badRequest))
                }
        }
    }
    
    func weathersListResponse(appid: String, lat: Double, lon: Double, units: String, completion: @escaping ((WeatherResponseData<WeatherResponse>) -> Void)) {
        BaseService.shared.post(endpoint: "/forecast?appid=\(appid)&lat=\(lat)&lon=\(lon)&units=\(units)", object: [:], for: .unsecure)
            .responseString { (response) in
                //print(response.result.value ?? "result value is nil")
                if let responseHttp = response.response, let value = response.result.value {
                    if let baseResponse = BaseService.shared.checkBaseResponse(responseHttp, value) {
                        return completion(.base(response: baseResponse))
                    }
                } else {
                    return completion(.isOffline)
                }
                switch response.response?.statusCode ?? 400 {
                case 200:
                    if let value = response.result.value, let data = Mapper<WeatherResponse>().map(JSONString: value) {
                        return completion(.success(results: data))
                    }
                    return completion(.base(response: .unexpectedError(error: ResponseUnexpectedError.mappingFailed)))
                default:
                    return completion(.base(response: .badRequest))
                }
        }
    }
}
