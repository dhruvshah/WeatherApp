//
//  EndPoint.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

enum Endpoint {
    case location
    case forecast
    case current
    case stations
}

struct APIEndpoint {
    let baseURL: URL
    
    init() {
        baseURL = URL(string: "https://api.weather.gov/")!
    }
    
    func locationUrl(latitude: Double, longitude: Double) -> URL {
        let components = URLComponents(url: baseURL.appendingPathComponent("points/\(latitude),\(longitude)"), resolvingAgainstBaseURL: false)
        
        return components!.url!
    }
    
    func currentWeatherUrl(observationStation: String) -> URL {
        let components = URLComponents(url: baseURL.appendingPathComponent("/stations/\(observationStation)/observations/latest"), resolvingAgainstBaseURL: false)
        
        return components!.url!
    }
}
