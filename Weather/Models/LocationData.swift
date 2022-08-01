//
//  LocationData.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

struct LocationData: SearchType {
    static var endpoint = Endpoint.location
    var properties: Property
}

struct Property: Codable {
    var gridX: Int
    var gridY: Int
    var cwa: String
    var forecast: String
    var forecastHourly: String
    var observationStations: String
}
