//
//  LoginAPI.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 7/02/21.
//

import Foundation

protocol LoginAPI {
    var networkLoginOperation: LoginOperation { get }
    func login(at endpoint: Endpoint, name: String, password: String, completion: LoginBlock?)
}

extension LoginAPI {

    func login(at endpoint: Endpoint, name: String, password: String, completion: LoginBlock? = nil) {
        login(at: endpoint, name: name, password: password, completion: completion)
    }
}
