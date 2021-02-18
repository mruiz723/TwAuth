//
//  AlertProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

import UIKit

protocol AlertProtocol {
    func showAlert(withMessage message: String, actions: [UIAlertAction]?)
}

extension AlertProtocol {

    func showAlert(withMessage message: String, actions: [UIAlertAction]? = nil) {
        showAlert(withMessage: message, actions: actions)
    }
}
