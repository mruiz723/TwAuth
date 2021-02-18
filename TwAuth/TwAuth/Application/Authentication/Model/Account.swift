//
//  Account.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 15/02/21.
//

import Foundation
import TwilioVerify

struct Account: Codable {
    var id: String?
    var accessToken: AccessTokenResponse?
    var factorSid: String?
}
