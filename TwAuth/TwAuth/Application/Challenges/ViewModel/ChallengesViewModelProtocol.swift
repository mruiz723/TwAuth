//
//  ChallengesViewModelProtocol.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation
import MRCommons
import TwilioVerify

protocol ChallengesViewModelProtocol: BaseViewModelProtocol {
    var challenges: Bindable<[Challenge]?> { get set }
    var showChallengeDetail: ((_ factorSid: String, _ challengeSid: String) -> Void)? { get set }
    func loadData()
    func makeViewModelForChallengeTableViewCell(at indexPath: IndexPath) -> ChallengeTableViewCellViewModel
    func didSelectRow(at index: Int)
}
