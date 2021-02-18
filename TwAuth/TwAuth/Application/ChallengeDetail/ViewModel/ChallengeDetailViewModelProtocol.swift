//
//  ChallengeDetailViewModelProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 16/02/21.
//

import Foundation
import MRCommons
import TwilioVerify

protocol ChallengeDetailViewModelProtocol: BaseViewModelProtocol {
    var challenge: Bindable<Challenge?> { get set }
    func viewDidLoad()
    func updateChallenge(withStatus status: ChallengeStatus)
}
