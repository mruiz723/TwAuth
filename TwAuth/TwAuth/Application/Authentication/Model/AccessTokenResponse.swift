//
//  AccessTokenResponse.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 1/02/21.
//

import Foundation

struct AccessTokenResponse: Codable {
  let token: String
  let serviceSid: String
  let identity: String
  let factorType: String
}
