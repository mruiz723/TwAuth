//
//  Constants.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 1/02/21.
//

import Foundation

struct Constants {

    static let name: String = "name"
    static let password: String = "password"
    static let id: String = "id"
    static let sid: String = "sid"
    static let scheme = "https"
    static let baseURL = "156ac9ec01a8.ngrok.io"
    static let pushToken = "0000000000000000000000000000000000000000000000000000000000000000"
    static let pageSize = 20
    static let launchedBefore = "launchedBefore"

    struct Keychain {
        static let service = "com.mruiz72.TwAuth"
        static let factorSid = "factorSid"
    }

    struct Title {
        static let authentication = "Authentication"
        static let challenges = "challenges"
    }

    struct AlertTitle {
        static let authentication = "Authentication"
        static let challenges = "Challenges"
        static let Challenge = "Challenge"
    }

    struct ActionTitle {
        static let ok = "OK"
    }
}
