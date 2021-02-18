//
//  ChallengeTableViewCell.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//
//

import UIKit
import TwilioVerify

class ChallengeTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var expirationDateLabel: UILabel!

    // MARK: - Constants

    static let reuseIdentifier = String(describing: ChallengeTableViewCell.self)

    // MARK: - Properties

    var viewModel: ChallengeTableViewCellViewModelProtocol! {
        didSet {
            viewModel.message.bindAndFire { [weak self] newValue in
                self?.messageLabel.text = newValue
            }

            viewModel.expirationDate.bindAndFire { [weak self] newValue in
                self?.expirationDateLabel.text = newValue
            }
        }
    }
}
