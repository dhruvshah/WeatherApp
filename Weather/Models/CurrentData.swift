//
//  CurrentData.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

enum TemperatureUnit: String {
    case degrees = "wmoUnit:degC"
    case farenheit = "wmoUnit:degF"
}

enum WindSpeedUnit: String {
    case kmPerHour = "wmoUnit:km_h-1"
}

struct CurrentData: SearchType {
    static var endpoint = Endpoint.current
    let properties: CurrentCondition
}

struct CurrentCondition: Decodable {
    var textDescription: String?
    var temperature: Temperature
    var dewpoint: DewPoint?
    var windSpeed: WindSpeed
    var heatIndex: HeatIndex?
    var relativeHumidity: Humidity
    var icon: String?
}

struct Temperature: Decodable {
    var value: Double?
    var unitCode: String
    
    init(value: Double?, unitCode: String) {
        if let temp = value {
            self.value = Double(temp)
        }
        self.unitCode = unitCode
    }
    
    enum CodingKeys: String, CodingKey {
        case value = "value", unitCode = "unitCode"
    }
}

struct DewPoint: Decodable {
    var value: Double?
    var unitCode: String
    
    init(value: Double?, unitCode: String) {
        if let dewpoint = value {
            self.value = Double(dewpoint)
        }
        self.unitCode = unitCode
    }
    
    enum CodingKeys: String, CodingKey {
        case value = "value", unitCode = "unitCode"
    }
}

struct WindSpeed: Decodable {
    var value: Double?
    var unitCode: String
    
    init(value: Double?, unitCode: String) {
        if let windSpeed = value {
            self.value = Double(windSpeed)
        }
        self.unitCode = unitCode
    }
    
    enum CodingKeys: String, CodingKey {
        case value = "value", unitCode = "unitCode"
    }
}

struct HeatIndex: Decodable {
    var value: Double?
    var unitCode: String
    
    init(value: Double?, unitCode: String) {
        if let heatindex = value {
            self.value = Double(heatindex)
        }
        self.unitCode = unitCode
    }
    
    enum CodingKeys: String, CodingKey {
        case value = "value", unitCode = "unitCode"
    }
}

struct Humidity: Decodable {
    var value: Double?
    
    init(value: Double?) {
        if let humidity = value {
            self.value = Double(humidity)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
    }
}

