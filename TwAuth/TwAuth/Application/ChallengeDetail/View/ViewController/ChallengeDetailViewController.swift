//
//  ChallengeDetailViewController.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 16/02/21.
//

import UIKit
import MRCommons
import TwilioVerify

class ChallengeDetailViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var detailsTextView: UITextView!
    @IBOutlet private weak var detailsHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var sidLabel: UILabel!
    @IBOutlet private weak var expirationDateLabel: UILabel!
    @IBOutlet private weak var updatedDateLabel: UILabel!
    @IBOutlet private weak var denyButton: UIButton!
    @IBOutlet private weak var approveButton: UIButton!
    @IBOutlet private weak var buttonsContainer: UIView!
    @IBOutlet private weak var closeButton: UIBarButtonItem!

    // MARK: - Properties

    weak var coordinator: ChallengeDetailCoordinator?

    var viewModel: ChallengeDetailViewModelProtocol! {
        didSet {
            loadViewIfNeeded()

            viewModel.challenge.bind { [weak self] newValue in
                guard let challenge = newValue else { return }
                self?.updateView(challenge)
            }

            viewModel.shouldShowLoader = { [weak self] shouldShow in
                self?.shouldShowLoader(shouldShow)
            }

            viewModel.showAlert = { [weak self] message in
                self?.showAlert(msg: message)
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupUI()
    }

    // MARK: - IBActions

    @IBAction func updateChallenge(_ sender: UIButton) {
        viewModel.updateChallenge(withStatus: sender.tag == 0 ? .denied : .approved)
    }
}

// MARK: - Private Methods

private extension ChallengeDetailViewController {
    func updateView(_ challenge: Challenge) {
        messageLabel.text = challenge.challengeDetails.message
        statusLabel.text = challenge.status.rawValue
        sidLabel.text = challenge.sid

        var detailText = String()

        challenge.challengeDetails.fields.forEach {
            detailText.append("\($0.label): \($0.value)\n")
        }

        if let hiddenDetails = challenge.hiddenDetails {
            detailText.append("Hidden Details\n")
            hiddenDetails.forEach {
                detailText.append("  \($0.key): \($0.value)\n")
            }
        }

        detailsTextView.text = detailText
        detailsHeightConstraint.constant = detailsTextView.contentSize.height
        expirationDateLabel.text = challenge.expirationDate.verifyStringFormat()
        updatedDateLabel.text = challenge.updatedAt.verifyStringFormat()
        buttonsContainer.isHidden = !(challenge.status == .pending)
        detailsTextView.layoutSubviews()
    }

    func setupUI() {
        closeButton.target = self
        closeButton.action = #selector(dismissView)
        denyButton.layer.cornerRadius = 8
        approveButton.layer.cornerRadius = 8
        buttonsContainer.isHidden = true
    }

    @objc func dismissView() {
        coordinator?.dismissView()
    }
}
