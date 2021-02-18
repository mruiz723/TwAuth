//
//  AuthenticationManagerProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 13/02/21.
//

import Foundation
import TwilioVerify

protocol AuthenticationManagerProtocol {
    func login(name: String, password: String, completion: @escaping AuthenticationBlock)
}
