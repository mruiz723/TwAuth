//
//  Endpoint.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 1/02/21.
//

import Foundation

struct Endpoint {

    let path: String
    let queryItems: [URLQueryItem]

    init(path: String, queryItems: [URLQueryItem] = [URLQueryItem]()) {
        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint {

    static func login() -> Endpoint {
        return Endpoint(
            path: "/api/login"
        )
    }

    static func accessToken() -> Endpoint {
        return Endpoint(
            path: "/api/devices/token"
        )
    }

    static func register() -> Endpoint {
        return Endpoint(
            path: "/api/devices/register"
        )
    }
}

extension Endpoint {

    var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.path = path
        components.queryItems = queryItems.count > 0 ? queryItems : nil

        return components.url
    }
}
