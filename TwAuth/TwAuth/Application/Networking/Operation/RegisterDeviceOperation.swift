//
//  RegisterDeviceOperation.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 9/02/21.
//

import Foundation
import MRCommons

final class RegisterDeviceOperation: AsyncOperation {

    // MARK: - Properties

    var account: Account?
    var completion: AuthenticationBlock?
    var endpoint: Endpoint?

    // MARK: - Initializer

    override func main() {
        registerDevice(completion: completion)
    }
}

// MARK: - Private Methods

private extension RegisterDeviceOperation {

    // swiftlint:disable cyclomatic_complexity function_body_length
    func registerDevice(completion: AuthenticationBlock? = nil) {
        let dependencyAccount = dependencies
            .compactMap { ($0 as? AccountDataProvider)?.account }
            .first

        guard let account = dependencyAccount, let id = account.id, let sid = account.factorSid else {
            cancel()
            return
        }

        guard let endpoint = endpoint else {
            cancel()
            completion?(.failure(TwAuthError.invalidURL))
            return
        }

        do {
            let request = try URLRequestBuilder(withURL: endpoint.url)
                .setHTTPMethod(.post)
                .setParameters(createRegisterBody(id: id, sid: sid))
                .build()

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
                          let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
                        completion?(.failure(TwAuthError.invalidData))
                        return
                    }

                    guard registerResponse.done else {
                        return
                    }

                    completion?(.success(account))
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
        } catch {
            cancel()
            completion?(.failure(error))
        }
    }
    // swiftlint:enable cyclomatic_complexity function_body_length

    func createRegisterBody(id: String, sid: String) throws -> [Parameter] {
        let body = [
            Parameter(name: Constants.id, value: id),
            Parameter(name: Constants.sid, value: sid)
        ]

        return body
    }
}

// MARK: - AccountProvider

extension RegisterDeviceOperation: AccountDataProvider { }
