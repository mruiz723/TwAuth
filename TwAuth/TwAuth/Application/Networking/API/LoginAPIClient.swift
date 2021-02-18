//
//  LoginAPIClient.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 7/02/21.
//

import Foundation
import UIKit
import MRCommons

typealias LoginBlock = (Result<LoginResponse, Error>) -> Void

class LoginAPIClient: LoginAPI {

    var networkLoginOperation: LoginOperation
    var id: String?
    private let completion: LoginBlock?

    init(completion: LoginBlock? = nil, networkLoginOperation: LoginOperation = LoginOperation()) {
        self.completion = completion
        self.networkLoginOperation = networkLoginOperation
    }

    func login(at endpoint: Endpoint, name: String, password: String, completion: LoginBlock? = nil) {
        if networkLoginOperation.state != .ready {
            networkLoginOperation = LoginOperation()
        }

        networkLoginOperation.completion = completion

        do {
            let request = try URLRequestBuilder(withURL: endpoint.url)
                .setHTTPMethod(.post)
                .setParameters(createLoginBody(name: name, password: password))
                .build()
            networkLoginOperation.request = request
        } catch {
            completion?(.failure(error))
        }
    }
}

private extension LoginAPIClient {

    func createLoginBody(name: String, password: String) throws -> [Parameter] {
        let body = [
            Parameter(name: Constants.name, value: name),
            Parameter(name: Constants.password, value: password)
        ]

        return body
    }
}
