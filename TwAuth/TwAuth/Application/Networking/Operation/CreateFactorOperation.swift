//
//  CreateFactorOperation.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 9/02/21.
//

import Foundation
import TwilioVerify
import MRCommons

final class CreateFactorOperation: AsyncOperation {

    // MARK: - Properties

    var account: Account?
    var completion: FactorBlock?
    private let twilioVerify: TwilioVerify?

    // MARK: - Initializer

    override init() {
        twilioVerify = try? TwilioVerifyBuilder().build()
        super.init()
    }

    override func main() {
        createFactor(completion: completion)
    }
}

// MARK: - Private Methods

private extension CreateFactorOperation {

    func createFactor(completion: FactorBlock? = nil) {
        let dependencyAccount = dependencies
            .compactMap { ($0 as? AccountDataProvider)?.account }
            .first

        guard var account = dependencyAccount, let accessToken = account.accessToken else {
            cancel()
            return
        }

        let payload = PushFactorPayload(
            friendlyName: "\(accessToken.identity)\'s Factor",
            serviceSid: accessToken.serviceSid,
            identity: accessToken.identity,
            pushToken: Constants.pushToken,
            accessToken: accessToken.token
        )

        guard let twilioVerify = twilioVerify else {
            cancel()
            return
        }

        twilioVerify.createFactor(withPayload: payload, success: { factor in
            let payload = VerifyPushFactorPayload(sid: factor.sid)

            twilioVerify.verifyFactor(withPayload: payload, success: { [weak self] factor in
                guard let self = self else { return }

                defer { self.state = .finished }

                account.factorSid = factor.sid
                self.account = account
                completion?(.success(factor))
            }, failure: { [weak self] error in
                guard let self = self else { return }

                defer { self.state = .finished }

                completion?(.failure(error))
            })

        }, failure: { [weak self] error in
            guard let self = self else { return }

            defer { self.state = .finished }

            completion?(.failure(error))
        })
    }
}

// MARK: - AccountDataProvider

extension CreateFactorOperation: AccountDataProvider { }
