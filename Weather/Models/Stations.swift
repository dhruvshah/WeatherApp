//
//  Stations.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

struct Stations: SearchType {
    static var endpoint = Endpoint.stations
    var features: [Feature]
}

struct Feature: Codable {
    var properties: Identifier
}

struct Identifier: Codable {
    var stationIdentifier: String
    var name: String
}

