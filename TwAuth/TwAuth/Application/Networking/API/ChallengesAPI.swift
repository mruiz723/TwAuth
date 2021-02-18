//
//  ChallengesAPI.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation
import TwilioVerify

typealias ChallengesBlock = (Result<[Challenge], Error>) -> Void

protocol ChallengesAPI {
    var twilioVerify: TwilioVerify? { get }
    func fetchChallenges(factorSid: String, completion: @escaping ChallengesBlock)
}
