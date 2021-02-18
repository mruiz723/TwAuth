//
//  CreateFactorAPI.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 9/02/21.
//

import Foundation

protocol CreateFactorAPI {
    var createFactorOperation: CreateFactorOperation { get }
    func createFactor(completion: FactorBlock?)
}

extension CreateFactorAPI {

    func createFactor(completion: FactorBlock? = nil) {
        createFactor(completion: completion)
    }
}
