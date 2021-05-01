//
//  URLSession+NetworkSession.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 30/04/21.
//

import Foundation

typealias DataBlock = (Result<Data, Error>) -> Void

protocol NetworkSession {
    func loadData(with request: URLRequest,
                  completion: @escaping DataBlock)
}

extension URLSession: NetworkSession {
    func loadData(with request: URLRequest, completion: @escaping DataBlock) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(TwAuthError.invalidResponse))
                return
            }

            switch httpResponse.statusCode {
            case 200..<300:
                guard let data = data else {
                    completion(.failure(TwAuthError.invalidData))
                    return
                }

                completion(.success(data))
            case 401, 403, 405, 407:
                completion(.failure(TwAuthError.unauthorized))
            case 400, 404:
                completion(.failure(TwAuthError.invalidURL))
            case 500..<511:
                completion(.failure(TwAuthError.serverError))
            default:
                completion(.failure(TwAuthError.unknown))
            }
        }.resume()
    }
}
