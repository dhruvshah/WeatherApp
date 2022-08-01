//
//  SearchType.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

// protocol for search types, used for generics in data manager
protocol SearchType: Decodable {
    static var endpoint: Endpoint { get }
}
