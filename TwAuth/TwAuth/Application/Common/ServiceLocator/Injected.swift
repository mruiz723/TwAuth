//
//  Injected.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation

@propertyWrapper struct Injected<T> {
    private let service: ServiceLocator.ServiceType?

    var wrappedValue: T? {
        guard let service = service else {
            return nil
        }

        return ServiceLocator.shared.service(key: service) as? T
    }

    init(service: ServiceLocator.ServiceType?) {
        self.service = service
    }
}
