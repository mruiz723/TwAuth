//
//  ChallengesCoordinator.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import UIKit
import MRCommons

class ChallengesCoordinator: ChallengesCoordinatorProtocol {

    var childCoordinator: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    private let factorSid: String

    init(navigationController: UINavigationController, factorSid: String) {
        self.navigationController = navigationController
        self.factorSid = factorSid
    }

    func start() {
        let challengesVC = ChallengesFactory.makeViewController(factorSid: factorSid)
        challengesVC.coordinator = self
        navigationController.pushViewController(challengesVC, animated: true)
    }

    func loadChallengeDetail(forFactorSid factorSid: String, challengeSid: String) {
        let coordinator: ChallengeDetailCoordinator = ChallengeDetailCoordinator(navigationController: navigationController, factorSid: factorSid, challengeSid: challengeSid)
        childCoordinator.append(coordinator)
        coordinator.start()
    }
}
