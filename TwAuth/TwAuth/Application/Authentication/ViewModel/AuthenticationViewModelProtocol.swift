//
//  AuthenticationViewModelProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 28/01/21.
//

import Foundation
import MRCommons

enum NameTextField {
    case name
    case password
}

protocol AuthenticationViewModelProtocol: BaseViewModelProtocol {
    var isSubmitButtonEnabled: Bindable<Bool> { get set }
    var showChallenges: ((_ factorSid: String) -> Void)? { get set }
    func didTapLoginButton()
    func textFieldDidChange(with data: String, nameTextField: NameTextField)
}
