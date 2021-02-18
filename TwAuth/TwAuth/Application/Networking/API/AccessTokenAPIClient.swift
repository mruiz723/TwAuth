//
//  AccessTokenAPIClient.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 7/02/21.
//

import Foundation

typealias AccessTokenBlock = (Result<AccessTokenResponse, Error>) -> Void

class AccessTokenAPIClient: AccessTokenAPI {

    var networkAccessTokenOperation: AccessTokenOperation
    private let completion: AccessTokenBlock?

    init(completion: AccessTokenBlock? = nil, networkAccessTokenOperation: AccessTokenOperation = AccessTokenOperation()) {
        self.completion = completion
        self.networkAccessTokenOperation = networkAccessTokenOperation
    }

    func accessToken(at endpoint: Endpoint, completion: AccessTokenBlock? = nil) {
        if networkAccessTokenOperation.state != .ready {
            networkAccessTokenOperation = AccessTokenOperation()
        }

        networkAccessTokenOperation.completion = completion
        networkAccessTokenOperation.endpoint = endpoint
    }
}
