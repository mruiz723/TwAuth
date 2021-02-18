//
//  ChallengeAPIClientMock.swift
//  TwAuthTests
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

import Foundation
@testable import TwAuth
import TwilioVerify

class ChallengeAPIClientMock: ChallengeAPI {
    var twilioVerify: TwilioVerify?
    var challenge: Challenge?
    var error: Error?

    func fetchChallengeDetail(challengeSid: String, factorSid: String, completion: @escaping ChallengeBlock) {
        if let challenge = challenge {
            completion(.success(challenge))
        } else if let error = error {
            completion(.failure(error))
        }
    }

    func updateChallenge(withPayload payload: UpdateChallengePayload, challengeSid: String, factorSid: String, completion: @escaping ChallengeBlock) {
        if let challenge = challenge {
            completion(.success(challenge))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}
