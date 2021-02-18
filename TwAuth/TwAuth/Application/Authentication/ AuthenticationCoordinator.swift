//
//   AuthenticationCoordinator.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 28/01/21.
//

import UIKit
import MRCommons

class AuthenticationCoordinator: AuthenticationCoordinatorProtocol {

    var childCoordinator: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let authenticationVC = AuthenticationFactory.makeViewController()
        authenticationVC.coordinator = self
        navigationController.setViewControllers([authenticationVC], animated: true)
    }

    func didAuthenticate(factorSid: String) {
        let challengesCoordinator: ChallengesCoordinator = ChallengesCoordinator(navigationController: navigationController, factorSid: factorSid)
        childCoordinator.append(challengesCoordinator)
        challengesCoordinator.start()
    }
}
