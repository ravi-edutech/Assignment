//
//  HTTPClientFactory.swift
//  MVP
//
//  Created by Ravi Kumar on 29/08/23.
//

import Foundation

class HTTPClientFactory {
    static func create() -> HTTPClientProtocol {
        return HTTPClient()
    }
}
