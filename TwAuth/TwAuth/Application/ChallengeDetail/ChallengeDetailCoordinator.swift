//
//  ChallengeDetailCoordinator.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 16/02/21.
//

import UIKit
import MRCommons

class ChallengeDetailCoordinator: ChallengeDetailCoordinatorProtocol {

    var childCoordinator: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    private let factorSid: String
    private let challengeSid: String

    init(navigationController: UINavigationController, factorSid: String, challengeSid: String) {
        self.navigationController = navigationController
        self.factorSid = factorSid
        self.challengeSid = challengeSid
    }

    func start() {
        let challengeDetailVC = ChallengeDetailFactory.makeViewController(factorSid: factorSid, challengeSid: challengeSid)
        challengeDetailVC.coordinator = self
        navigationController.pushViewController(challengeDetailVC, animated: true)
    }

    func dismissView() {
        navigationController.popViewController(animated: true)
    }
}
