//
//  DataManager.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

// takes generic searchtype conforming object
struct DataManager<T: SearchType> {
    static func fetch(url: URL, completion: @escaping (Result<T>) -> Void) {
        NetworkFetcher.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.nwsApiDecoder.decode(T.self, from: data) else {
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

