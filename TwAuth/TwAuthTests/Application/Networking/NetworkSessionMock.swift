//
//  NetworkSessionMock.swift
//  TwAuthTests
//
//  Created by Marlon David Ruiz Arroyave on 30/04/21.
//

import Foundation
@testable import TwAuth

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?

    func loadData(with request: URLRequest,
                  completion: @escaping DataBlock) {
        if let error = error {
            completion(.failure(error))
        }

        guard let data = data else {
            completion(.failure(TwAuthError.invalidData))
            return
        }

        completion(.success(data))
    }
}
