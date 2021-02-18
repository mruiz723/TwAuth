//
//  ChallengeDetailViewModel.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 16/02/21.
//

import Foundation
import MRCommons
import TwilioVerify

class ChallengeDetailViewModel: ChallengeDetailViewModelProtocol {

    // MARK: - Properties

    private let factorSid: String
    private let challengeSid: String
    var challenge: Bindable<Challenge?> = Bindable(nil)
    @Injected(service: .challengeAPIClient) private var challengeAPIClient: ChallengeAPI?

    // MARK: - Events

    var shouldShowLoader: ((Bool) -> Void)?
    var showAlert: ((String) -> Void)?

    // MARK: - Life Cycle

    init(factorSid: String, challengeSid: String) {
        self.factorSid = factorSid
        self.challengeSid = challengeSid
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        self.shouldShowLoader?(true)
        challengeAPIClient?.fetchChallengeDetail(challengeSid: challengeSid, factorSid: factorSid) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.shouldShowLoader?(false)

                switch result {
                case .success(let challenge):
                    self.challenge.value = challenge
                case .failure(let error):
                    self.showAlert?(error.localizedDescription)
                }
            }
        }
    }

    func updateChallenge(withStatus status: ChallengeStatus) {
        self.shouldShowLoader?(true)

        let payload = UpdatePushChallengePayload(
            factorSid: factorSid,
            challengeSid: challengeSid,
            status: status
        )

        challengeAPIClient?.updateChallenge(withPayload: payload, challengeSid: challengeSid, factorSid: factorSid) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.shouldShowLoader?(false)

                switch result {
                case .success(let challenge):
                    DispatchQueue.main.async {
                        self.challenge.value = challenge
                    }
                case .failure(let error):
                    self.showAlert?(error.localizedDescription)
                }
            }
        }
    }
}
