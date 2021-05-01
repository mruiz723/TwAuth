//
//  AccessTokenOperation.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 8/02/21.
//

import Foundation
import MRCommons

final class AccessTokenOperation: AsyncOperation {

    // MARK: - Properties

    private let session: NetworkSession
    var account: Account?
    var request: URLRequest?
    var completion: AccessTokenBlock?
    var endpoint: Endpoint?

    // MARK: - Initializer

    init(session: NetworkSession) {
        self.session = session
    }

    override func main() {
        accessToken(completion: completion)
    }
}

// MARK: - Private Methods

private extension AccessTokenOperation {

    func accessToken(completion: AccessTokenBlock? = nil) {
        let dependencyAccount = dependencies
            .compactMap { ($0 as? AccountDataProvider)?.account }
            .first

        guard var account = dependencyAccount, let id = account.id else {
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
                .setParameters(createTokenBody(id: id))
                .build()
            session.loadData(with: request) {  [weak self] result in
                guard let self = self else { return }

                defer { self.state = .finished }

                switch result {
                case .failure(let error):
                    completion?(.failure(error))
                case .success(let data):
                    guard let accessTokenResponse = try? JSONDecoder().decode(AccessTokenResponse.self, from: data) else {
                        completion?(.failure(TwAuthError.invalidData))
                        return
                    }

                    account.accessToken = accessTokenResponse
                    self.account = account
                    completion?(.success(accessTokenResponse))
                }
            }

        } catch {
            cancel()
            completion?(.failure(error))
        }
    }

    func createTokenBody(id: String) throws -> [Parameter] {
        let body = [
            Parameter(name: Constants.id, value: id)
        ]

        return body
    }
}

// MARK: - AccountDataProvider

extension AccessTokenOperation: AccountDataProvider { }
