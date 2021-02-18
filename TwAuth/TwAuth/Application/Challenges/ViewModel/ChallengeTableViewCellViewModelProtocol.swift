//
//  ChallengeTableViewCellViewModelProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation
import MRCommons

protocol ChallengeTableViewCellViewModelProtocol {
    var message: Bindable<String> { get }
    var expirationDate: Bindable<String> { get }
}
