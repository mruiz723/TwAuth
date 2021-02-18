//
//  AuthenticationManager.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 13/02/21.
//

import Foundation
import MRCommons
import TwilioVerify
import KeychainAccess

typealias AuthenticationBlock = (Result<Account, Error>) -> Void

final class AuthenticationManager: AuthenticationManagerProtocol {
    private let queue: OperationQueue

    @Injected(service: .loginAPIClient) private var loginAPIClient: LoginAPI?
    @Injected(service: .accessTokenAPIClient) private var accessTokenAPIClient: AccessTokenAPI?
    @Injected(service: .createFactorAPIClient) private var createFactorAPIClient: CreateFactorAPI?
    @Injected(service: .registerDeviceAPIClient) private var registerDeviceAPIClient: RegisterDeviceAPI?

    init(queue: OperationQueue = OperationQueue()) {
        self.queue = queue
    }

    func login(name: String, password: String, completion: @escaping AuthenticationBlock) {
        queue.cancelAllOperations()

        // swiftlint:disable line_length
        guard let loginAPIClient = loginAPIClient, let accessTokenAPIClient =  accessTokenAPIClient, let createFactorAPIClient = createFactorAPIClient, let registerDeviceAPIClient = registerDeviceAPIClient else {
            return completion(.failure(TwAuthError.invalidBody))
        }
        // swiftlint:enable line_length

        loginAPIClient.login(at: Endpoint.login(), name: name, password: password) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            default:
                break
            }
        }

        accessTokenAPIClient.accessToken(at: Endpoint.accessToken()) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            default:
                break
            }
        }

        createFactorAPIClient.createFactor { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            default:
                break
            }
        }

        registerDeviceAPIClient.register(at: Endpoint.register()) {[weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let account):
                self.save(account: account)
                completion(.success(account))
            case .failure(let error):
                completion(.failure(error))
            }
        }

        accessTokenAPIClient.networkAccessTokenOperation.addDependency(loginAPIClient.networkLoginOperation)
        createFactorAPIClient.createFactorOperation.addDependency(accessTokenAPIClient.networkAccessTokenOperation)
        registerDeviceAPIClient.registerOperation.addDependency(createFactorAPIClient.createFactorOperation)

        queue.addOperation(loginAPIClient.networkLoginOperation)
        queue.addOperation(accessTokenAPIClient.networkAccessTokenOperation)
        queue.addOperation(createFactorAPIClient.createFactorOperation)
        queue.addOperation(registerDeviceAPIClient.registerOperation)
    }
}

private extension AuthenticationManager {
    func save(account: Account) {
        let keychain = Keychain(service: Constants.Keychain.service)
        keychain[Constants.Keychain.factorSid] = account.factorSid
    }
}
