//
//  AuthenticationFactory.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 28/01/21.
//

import UIKit

struct AuthenticationFactory {

    static func makeViewController() -> AuthenticationViewController {
        let authenticationVC = AuthenticationViewController.instantiate()
        let viewModel = AuthenticationViewModel()
        authenticationVC.viewModel = viewModel
        return authenticationVC
    }
}
