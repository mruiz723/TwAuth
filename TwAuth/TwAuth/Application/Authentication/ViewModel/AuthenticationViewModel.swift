//
//  AuthenticationViewModel.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 28/01/21.
//

import Foundation
import MRCommons
import TwilioVerify

class AuthenticationViewModel: AuthenticationViewModelProtocol {

    // MARK: - Properties

    private var name: String = ""
    private var password: String = ""
    private var authenticationManager: AuthenticationManagerProtocol
    var isSubmitButtonEnabled: Bindable<Bool> = Bindable(false)

    // MARK: Events

    var showAlert: ((_ message: String) -> Void)?
    var showChallenges: ((_ factorSid: String) -> Void)?
    var shouldShowLoader: ((Bool) -> Void)?

    // MARK: - Initializer

    init(authenticationManager: AuthenticationManagerProtocol = AuthenticationManager()) {
        self.authenticationManager = authenticationManager
    }

    // MARK: - Public Methods

    func didTapLoginButton() {
        shouldShowLoader?(true)
        authenticationManager.login(name: name, password: password) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.shouldShowLoader?(false)

                switch result {
                case .success(let account):
                    guard let factorSid = account.factorSid else { return }
                    self.showChallenges?(factorSid)
                case .failure(let error):
                    self.showAlert?(error.localizedDescription)
                }
            }
        }
    }

    func textFieldDidChange(with data: String, nameTextField: NameTextField) {
        switch nameTextField {
        case .name:
            name = data
        case .password:
            password = data
        }

        isSubmitButtonEnabled.value = name.count > 0 && password.count > 0
    }
}
