//
//  Result.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

// enum to manage results from data manager
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

