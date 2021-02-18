//
//  AuthenticationCoordinatorProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 28/01/21.
//

import Foundation
import MRCommons

protocol AuthenticationCoordinatorProtocol: Coordinator {
    func didAuthenticate(factorSid: String)
}
