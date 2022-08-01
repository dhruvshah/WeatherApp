//
//  NetworkFetcher.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

struct NetworkFetcher {
    private static let session = URLSession(configuration: .default)
    
    static func getURL(endpoint: URL, completion: @escaping (Result<Data>) -> Void) {
        fetchData(url: endpoint, completion: completion)
    }
    
    static func fetchData(url: URL, completion: @escaping (Result<Data>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
        
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(Errors.networkError))
                return
            }
           
            if httpResponse.statusCode == 200 {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    completion(.success(data))
                }
            } else if httpResponse.statusCode == 404 {
                completion(.failure(Errors.noDataError))
            } else {
                completion(.failure(Errors.networkError))
            }
        }
        task.resume()
    }
}

