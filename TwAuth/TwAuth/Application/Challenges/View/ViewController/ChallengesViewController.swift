//
//  ChallengesViewController.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import UIKit
import MRCommons

class ChallengesViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    weak var coordinator: ChallengesCoordinator?

    var viewModel: ChallengesViewModelProtocol! {
        didSet {
            loadViewIfNeeded()

            viewModel.challenges.bind { [weak self] _ in
                self?.tableView.reloadData()
            }

            viewModel.showChallengeDetail = { [weak self] factorSid, challengeSid in
                self?.coordinator?.loadChallengeDetail(forFactorSid: factorSid, challengeSid: challengeSid)
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
}

// MARK: - Private Methods

private extension ChallengesViewController {

    func setup() {
        title = Constants.Title.challenges
        navigationItem.setHidesBackButton(true, animated: true)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: String(describing: ChallengeTableViewCell.self), bundle: nil), forCellReuseIdentifier: ChallengeTableViewCell.reuseIdentifier)
        tableView.refreshControl = refreshControl
    }

    @objc func loadData(refreshControl: UIRefreshControl) {
        viewModel.loadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource

extension ChallengesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.challenges.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChallengeTableViewCell.reuseIdentifier, for: indexPath) as? ChallengeTableViewCell else {
          return UITableViewCell()
        }

        cell.viewModel = viewModel.makeViewModelForChallengeTableViewCell(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChallengesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
}
