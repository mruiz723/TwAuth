//
//  TwAuthError.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

import Foundation

enum TwAuthError: LocalizedError {

    case invalidURL
    case invalidBody
    case invalidResponse
    case invalidData
    case unauthorized
    case serverError
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidBody:
            return "Invalid Body"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid Data"
        case .unauthorized:
            return "You are unauthorized to access"
        case .serverError, .unknown:
            return "Somehting went wronng. Try again later!"
        }
    }
}
