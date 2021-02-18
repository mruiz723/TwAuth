//
//  AppCoordinator.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 13/02/21.
//

import UIKit
import MRCommons
import KeychainAccess

class AppCoordinator: NSObject, Coordinator {

    // MARK: - Properties

    var childCoordinator: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var window: UIWindow

    // MARK: - Initializer

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    // MARK: - Public Methods

    func start() {
        navigationController.delegate = self

        if let factorSid = factorSid() {
            let challengesCoordinator: ChallengesCoordinator = ChallengesCoordinator(navigationController: navigationController, factorSid: factorSid)
            childCoordinator.append(challengesCoordinator)
            challengesCoordinator.start()
        } else {
            let authenticationCoordinator: AuthenticationCoordinator = AuthenticationCoordinator(navigationController: navigationController)
            childCoordinator.append(authenticationCoordinator)
            authenticationCoordinator.start()
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func chilDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinator.enumerated() where coordinator === child {
            childCoordinator.remove(at: index)
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if let challengeDetailVC = fromViewController as? ChallengeDetailViewController {
            chilDidFinish(challengeDetailVC.coordinator)
        }
    }
}

// MARK: - Private Methods

private extension AppCoordinator {
    func factorSid() -> String? {
        let keychain = Keychain(service: Constants.Keychain.service)
        return try? keychain.get(Constants.Keychain.factorSid)
    }
}
