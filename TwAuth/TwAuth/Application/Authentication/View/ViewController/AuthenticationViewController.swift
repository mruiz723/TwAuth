//
//  AuthenticationViewController.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 12/02/21.
//

import UIKit
import MRCommons
import SVProgressHUD

class AuthenticationViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    // MARK: - Properties

    weak var coordinator: AuthenticationCoordinator?

    var viewModel: AuthenticationViewModelProtocol! {
        didSet {
            loadViewIfNeeded()

            viewModel.isSubmitButtonEnabled.bindAndFire { [weak self] newValue in
                self?.signInButton.isEnabled = newValue
                self?.signInButton.alpha = newValue ? 1.0 : 0.5
            }

            viewModel.showChallenges = { [weak self] factorSid in
                self?.coordinator?.didAuthenticate(factorSid: factorSid)
            }

            viewModel.shouldShowLoader = { [weak self] shouldShow in
                self?.shouldShowLoader(shouldShow)
            }

            viewModel.showAlert = { [weak self] message in
                self?.showAlert(msg: message)
            }
        }
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Title.authentication
    }

    // MARK: - IBActions

    @IBAction func didTapLoginButton(_ sender: Any) {
        viewModel.didTapLoginButton()
    }
}

extension AuthenticationViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 {
            textFieldDidChange(textField, data: string)
        } else {
            if let text = textField.text, let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                textFieldDidChange(textField, data: updatedText)
            }
        }

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if passwordTextField == textField {
            textField.text = ""
            textFieldDidChange(textField, data: "")
        }
    }

    private func textFieldDidChange(_ textField: UITextField, data: String) {
        switch textField {
        case nameTextField:
            viewModel.textFieldDidChange(with: data, nameTextField: .name)
        case passwordTextField:
            viewModel.textFieldDidChange(with: data, nameTextField: .password)
        default:
            return
        }
    }
}
