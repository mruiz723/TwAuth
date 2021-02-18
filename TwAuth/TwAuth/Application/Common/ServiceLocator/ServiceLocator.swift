//
//  ServiceLocator.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation

final class ServiceLocator {

    // MARK: - Constants

    enum ServiceType: CaseIterable {
        case loginAPIClient
        case accessTokenAPIClient
        case createFactorAPIClient
        case registerDeviceAPIClient
        case challengesAPIClient
        case challengeAPIClient
    }

    // MARK: - Properties

    private var services: [ServiceType: Any] = [:]
    static let shared = ServiceLocator()

    // MARK: - Initializer

    private init() {
        registerDefaultValues()
    }

    // MARK: - Public Methods

    func register(key: ServiceType, value: Any) {
        services[key] = value
    }

    func service(key: ServiceType) -> Any? {
        return services[key]
    }

    // MARK: - Private Methods

    private func registerDefaultValues() {
        for service in ServiceType.allCases {
            var value: Any

            switch service {
            case .loginAPIClient:
                value = LoginAPIClient()
            case .accessTokenAPIClient:
                value = AccessTokenAPIClient()
            case .createFactorAPIClient:
                value = CreateFactorAPIClient()
            case .registerDeviceAPIClient:
                value = RegisterDeviceAPIClient()
            case .challengesAPIClient:
                value = ChallengesAPIClient()
            case .challengeAPIClient:
                value = ChallengeAPIClient()
            }

            services[service] = value
        }
    }
}
