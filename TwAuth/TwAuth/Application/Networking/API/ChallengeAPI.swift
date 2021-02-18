//
//  ChallengeAPI.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 16/02/21.
//

import Foundation
import TwilioVerify

typealias ChallengeBlock = (Result<Challenge, Error>) -> Void

protocol ChallengeAPI {
    var twilioVerify: TwilioVerify? { get }
    func fetchChallengeDetail(challengeSid: String, factorSid: String, completion: @escaping ChallengeBlock)
    func updateChallenge(withPayload payload: UpdateChallengePayload, challengeSid: String, factorSid: String, completion: @escaping ChallengeBlock)
}
