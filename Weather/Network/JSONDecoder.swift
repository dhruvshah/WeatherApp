//
//  JSONDecoder.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

// decoder for snakecase conversion
extension JSONDecoder {
    static var nwsApiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }
}
