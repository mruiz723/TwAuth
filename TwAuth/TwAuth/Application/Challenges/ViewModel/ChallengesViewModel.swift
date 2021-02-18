//
//  ChallengesViewModel.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation
import MRCommons
import TwilioVerify

class ChallengesViewModel: ChallengesViewModelProtocol {

    // MARK: - Properties

    private let factorSid: String
    var challenges: Bindable<[Challenge]?> = Bindable(nil)
    @Injected(service: .challengesAPIClient) private var challengesAPIClient: ChallengesAPI?

    // MARK: - Events

    var showChallengeDetail: ((_ factorSid: String, _ challengeSid: String) -> Void)?
    var shouldShowLoader: ((Bool) -> Void)?
    var showAlert: ((String) -> Void)?

    // MARK: - Life Cycle

    init(factorSid: String) {
        self.factorSid = factorSid
    }

    // MARK: - Public Methods

    func loadData() {
        shouldShowLoader?(true)
        challengesAPIClient?.fetchChallenges(factorSid: factorSid) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.shouldShowLoader?(false)

                switch result {
                case .success(let challenges):
                    self.challenges.value = challenges
                case .failure(let error):
                    self.showAlert?(error.localizedDescription)
                }
            }
        }
    }

    func makeViewModelForChallengeTableViewCell(at indexPath: IndexPath) -> ChallengeTableViewCellViewModel {
        guard let challenge = challenges.value?[indexPath.row] else {
            fatalError("A challenge is required")
        }

        return ChallengeTableViewCellViewModel(challenge: challenge)
    }

    func didSelectRow(at index: Int) {
        guard let challenge = challenges.value?[index] else { return }
        showChallengeDetail?(factorSid, challenge.sid)
    }
}
