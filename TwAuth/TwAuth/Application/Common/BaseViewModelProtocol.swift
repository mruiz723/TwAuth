//
//  BaseViewModelProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

import Foundation

protocol BaseViewModelProtocol {
    var shouldShowLoader: ((Bool) -> Void)? { get set }
    var showAlert: ((_ message: String) -> Void)? { get set }
}
