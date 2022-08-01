//
//  Error.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

// error to be used in the case of bad access to network
enum Errors: Error {
    case networkError
    case otherError
    case noDataError
    case noNetwork
    
    var localizedDescription: String {
        switch self {
        case .networkError:
            return Localized.networkError
        case .noNetwork:
            return Localized.noNetworkError
        case .otherError:
            return Localized.otherError
        case .noDataError:
            return Localized.noDataError
        }
    }
}
