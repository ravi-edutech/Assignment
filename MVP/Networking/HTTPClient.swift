//
// HTTPClient.swift
// MVP
// Created by Ravi kumar on 28/06/23.
//

import Foundation
import SwiftUI

enum NetworkError:Error{
    case badURL
    case noData
    case decodingError
}

    class HTTPClient {
        func getJoke(completion: @escaping (Result<String?, NetworkError>) -> Void) {
            let urlString = "https://geek-jokes.sameerkumar.website/api"
            
            guard let url = URL(string: urlString) else {
                return completion(.failure(.badURL))
            }
            
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForResource = 120
            sessionConfig.timeoutIntervalForRequest = 120
            let session = URLSession(configuration: sessionConfig)
            
            session.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return completion(.failure(.noData))
                }
                
                print("data \(data)")
                
                do {
                    let joke = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? String ?? "No joke found"
                    print("joke \(joke)")
                    completion(.success(joke))
                } catch {
                    print("json error \(error)")
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
    }
    


