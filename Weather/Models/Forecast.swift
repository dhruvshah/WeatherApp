//
//  Forecast.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

struct Forecast: SearchType {
    static var endpoint = Endpoint.forecast
    var properties: Properties
}

struct Properties: Codable {
    var periods: [ForecastData]
}

struct ForecastData: Codable {
    var name: String
    var isDaytime: Bool
    var temperature: Int
    var temperatureUnit: String
    var shortForecast: String
    var detailedForecast: String
    var icon: String
    var startTime: String
}
