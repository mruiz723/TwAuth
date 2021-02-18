//
//  LoginOperation.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 7/02/21.
//

import Foundation
import MRCommons

final class LoginOperation: AsyncOperation {

    // MARK: - Properties

    var account: Account?
    var completion: LoginBlock?
    var request: URLRequest?

    // MARK: - Initializer

    init(account: Account = Account()) {
        self.account = account
        super.init()
    }

    override func main() {
        login(completion: completion)
    }
}

// MARK: - Private Methods

private extension LoginOperation {

    func login(completion: LoginBlock? = nil) {
        guard let request = request else {
            cancel()
            completion?(.failure(TwAuthError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            defer { self.state = .finished }

            if let error = error {
                completion?(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion?(.failure(TwAuthError.invalidResponse))
                return
            }

            switch httpResponse.statusCode {
            case 200..<300:
                guard let data = data,
                      let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                    completion?(.failure(TwAuthError.invalidData))
                    return
                }

                self.account?.id = loginResponse.id
                completion?(.success(loginResponse))
            case 401, 403, 405, 407:
                completion?(.failure(TwAuthError.unauthorized))
            case 400, 404:
                completion?(.failure(TwAuthError.invalidURL))
            case 500..<511:
                completion?(.failure(TwAuthError.serverError))
            default:
                completion?(.failure(TwAuthError.unknown))
            }
        }.resume()
    }

    func createLoginBody(name: String, password: String) throws -> [Parameter] {
        let body = [
            Parameter(name: Constants.name, value: name),
            Parameter(name: Constants.password, value: password)
        ]

        return body
    }
}

// MARK: - AccountProvider

extension LoginOperation: AccountDataProvider { }
