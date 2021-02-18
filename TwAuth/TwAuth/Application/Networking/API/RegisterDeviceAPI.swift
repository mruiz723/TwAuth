//
//  RegisterDeviceAPI.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 9/02/21.
//

import Foundation

protocol RegisterDeviceAPI {
    var registerOperation: RegisterDeviceOperation { get }
    func register(at endpoint: Endpoint, completion: AuthenticationBlock?)
}

extension RegisterDeviceAPI {

    func register(at endpoint: Endpoint, completion: AuthenticationBlock? = nil) {
        register(at: endpoint, completion: completion)
    }
}
