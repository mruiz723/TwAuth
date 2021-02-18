//
//  ChallengesCoordinatorProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation
import MRCommons

protocol ChallengesCoordinatorProtocol: Coordinator {
    func loadChallengeDetail(forFactorSid factorSid: String, challengeSid: String)
}
