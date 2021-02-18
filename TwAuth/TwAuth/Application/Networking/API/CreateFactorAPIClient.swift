//
//  CreateFactorAPIClient.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 9/02/21.
//

import Foundation
import MRCommons
import TwilioVerify

typealias FactorBlock = (Result<Factor, Error>) -> Void

class CreateFactorAPIClient: CreateFactorAPI {

    var createFactorOperation: CreateFactorOperation

    init(createFactorOperation: CreateFactorOperation = CreateFactorOperation()) {
        self.createFactorOperation = createFactorOperation
    }

    func createFactor(completion: FactorBlock?) {
        if createFactorOperation.state != .ready {
            createFactorOperation = CreateFactorOperation()
        }

        createFactorOperation.completion = completion
    }
}
