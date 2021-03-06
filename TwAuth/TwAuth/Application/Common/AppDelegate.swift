//
//  AppDelegate.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 12/02/21.
//

import UIKit
import SVProgressHUD
import KeychainAccess

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SVProgressHUD.setDefaultMaskType(.black)
        cleanKeychainIfNeeded()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

private extension AppDelegate {
    func cleanKeychainIfNeeded() {
        let launchedBefore = UserDefaults.standard.bool(forKey: Constants.launchedBefore)

        if !launchedBefore {
            let keychain = Keychain(service: Constants.Keychain.service)
            keychain[Constants.Keychain.factorSid] = nil
            UserDefaults.standard.set(true, forKey: Constants.launchedBefore)
        }
    }
}
