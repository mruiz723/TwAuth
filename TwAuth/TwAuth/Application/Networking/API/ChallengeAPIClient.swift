//
//  ChallengeAPIClient.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 16/02/21.
//

import Foundation
import TwilioVerify

class ChallengeAPIClient: ChallengeAPI {

    private(set) var twilioVerify: TwilioVerify?

    init() {
        twilioVerify = try? TwilioVerifyBuilder().build()
    }

    func fetchChallengeDetail(challengeSid: String, factorSid: String, completion: @escaping ChallengeBlock) {
        guard let twilioVerify = twilioVerify else { return }

        twilioVerify.getChallenge(challengeSid: challengeSid, factorSid: factorSid, success: { challenge in
            completion(.success(challenge))
        }, failure: {  error in
            completion(.failure(error))
        })
    }

    func updateChallenge(withPayload payload: UpdateChallengePayload, challengeSid: String, factorSid: String, completion: @escaping ChallengeBlock) {
        guard let twilioVerify = twilioVerify else { return }

        twilioVerify.updateChallenge(withPayload: payload, success: { [weak self] in
            guard let self = self else { return }

            self.fetchChallengeDetail(challengeSid: challengeSid, factorSid: factorSid, completion: completion)
        }, failure: { error in
            completion(.failure(error))
        })
    }
}
