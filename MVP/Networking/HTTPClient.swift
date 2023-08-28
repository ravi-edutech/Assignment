//
// HTTPClient.swift
// MVP
// Created by Ravi kumar on 28/06/23.
//

import Foundation
import SwiftUI

class HTTPClient: HTTPClientProtocol {
    func request<T: Codable>(url:String,completion: @escaping (Result<[T]?, NetworkError>) -> Void) {
        let urlString = URLConstants.baseURL + url
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
            do {
                let users = try JSONDecoder().decode([T].self, from: data)
                completion(.success(users))
            } catch {
                return completion(.failure(.decodingError))
            }
        }.resume()
    }
}
    


