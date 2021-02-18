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

    var account: Account?
    var request: URLRequest?
    var completion: AccessTokenBlock?
    var endpoint: Endpoint?

    // MARK: - Initializer

    override func main() {
        accessToken(completion: completion)
    }
}

// MARK: - Private Methods

private extension AccessTokenOperation {

    // swiftlint:disable cyclomatic_complexity function_body_length
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
                          let accessTokenResponse = try? JSONDecoder().decode(AccessTokenResponse.self, from: data) else {
                        completion?(.failure(TwAuthError.invalidData))
                        return
                    }

                    account.accessToken = accessTokenResponse
                    self.account = account
                    completion?(.success(accessTokenResponse))
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

    func createTokenBody(id: String) throws -> [Parameter] {
        let body = [
            Parameter(name: Constants.id, value: id)
        ]

        return body
    }
}

// MARK: - AccountDataProvider

extension AccessTokenOperation: AccountDataProvider { }
