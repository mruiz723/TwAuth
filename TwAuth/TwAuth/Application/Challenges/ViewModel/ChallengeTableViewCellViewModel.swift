//
//  ChallengeTableViewCellViewModel.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation
import MRCommons
import TwilioVerify

class ChallengeTableViewCellViewModel: ChallengeTableViewCellViewModelProtocol {

    let message: Bindable<String>
    let expirationDate: Bindable<String>

    init(challenge: Challenge) {
        self.message = Bindable(challenge.challengeDetails.message)
        self.expirationDate =  Bindable(challenge.expirationDate.verifyStringFormat())
    }
}
