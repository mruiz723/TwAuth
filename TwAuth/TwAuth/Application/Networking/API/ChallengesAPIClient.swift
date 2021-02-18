//
//  ChallengesAPIClient.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation
import TwilioVerify

class ChallengesAPIClient: ChallengesAPI {

    private(set) var twilioVerify: TwilioVerify?

    init() {
        twilioVerify = try? TwilioVerifyBuilder().build()
    }

    func fetchChallenges(factorSid: String, completion: @escaping ChallengesBlock) {
        let payload = ChallengeListPayload(factorSid: factorSid, pageSize: Constants.pageSize)

        guard let twilioVerify = twilioVerify else {
            return
        }

        twilioVerify.getAllChallenges(withPayload: payload, success: { list in
            completion(.success(list.challenges))
        }, failure: { error in
            completion(.failure(error))
        })
    }
}
