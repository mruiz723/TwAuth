//
//  ChallengeDetailFactory.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 16/02/21.
//

import Foundation

struct ChallengeDetailFactory {

    static func makeViewController(factorSid: String, challengeSid: String) -> ChallengeDetailViewController {
        let challengeDetailViewController = ChallengeDetailViewController.instantiate()
        let viewModel = ChallengeDetailViewModel(factorSid: factorSid, challengeSid: challengeSid)
        challengeDetailViewController.viewModel = viewModel
        return challengeDetailViewController
    }
}
