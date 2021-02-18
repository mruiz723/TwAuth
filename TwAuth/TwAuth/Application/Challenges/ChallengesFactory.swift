//
//  ChallengesFactory.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation

struct ChallengesFactory {

    static func makeViewController(factorSid: String) -> ChallengesViewController {
        let challengesViewController = ChallengesViewController.instantiate()
        let viewModel = ChallengesViewModel(factorSid: factorSid)
        challengesViewController.viewModel = viewModel
        return challengesViewController
    }
}
