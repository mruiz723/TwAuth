//
//  RegisterDeviceAPIClient.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 9/02/21.
//

import Foundation

class RegisterDeviceAPIClient: RegisterDeviceAPI {

    var registerOperation: RegisterDeviceOperation

    init(registerOperation: RegisterDeviceOperation = RegisterDeviceOperation()) {
        self.registerOperation = registerOperation
    }

    func register(at endpoint: Endpoint, completion: AuthenticationBlock?) {
        if registerOperation.state != .ready {
            registerOperation = RegisterDeviceOperation()
        }

        registerOperation.completion = completion
        registerOperation.endpoint = endpoint
    }
}
