//
//  ChallengesAPIClientMock.swift
//  TwAuthTests
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

@testable import TwAuth
import TwilioVerify

class ChallengesAPIClientMock: ChallengesAPI {

    var twilioVerify: TwilioVerify?
    var challenges: [Challenge]?
    var error: Error?

    func fetchChallenges(factorSid: String, completion: @escaping ChallengesBlock) {
        if let challenges = challenges {
            completion(.success(challenges))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}
