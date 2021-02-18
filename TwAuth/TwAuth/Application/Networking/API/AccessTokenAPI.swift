//
//  AccessTokenAPI.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 7/02/21.
//

import Foundation

protocol AccessTokenAPI {
    var networkAccessTokenOperation: AccessTokenOperation { get }
    func accessToken(at endpoint: Endpoint, completion: AccessTokenBlock?)
}

extension AccessTokenAPI {

    func accessToken(at endpoint: Endpoint, completion: AccessTokenBlock? = nil) {
        accessToken(at: endpoint, completion: completion)
    }
}
