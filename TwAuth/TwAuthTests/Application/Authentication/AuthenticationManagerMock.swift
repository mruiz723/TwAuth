//
//  AuthenticationManagerMock.swift
//  TwAuthTests
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

@testable import TwAuth

class AuthenticationManagerMock: AuthenticationManagerProtocol {

    var account: Account?
    var error: Error?

    func login(name: String, password: String, completion: @escaping AuthenticationBlock) {

        if let account = account {
            completion(.success(account))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}
