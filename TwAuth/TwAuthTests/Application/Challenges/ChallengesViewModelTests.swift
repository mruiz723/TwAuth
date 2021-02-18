//
//  ChallengesViewModelTests.swift
//  TwAuthTests
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

import XCTest
@testable import TwAuth
import MRCommons
import TwilioVerify

class ChallengesViewModelTests: XCTestCase {

    private var challengesAPIClientMock: ChallengesAPIClientMock!

    func testInit() {
        let viewModel = ChallengesViewModel(factorSid: "factorSid")
        XCTAssertNil(viewModel.challenges.value, "challenges value should be nil")
    }

    func testLoadDataWithChallengesResultShouldTriggerChallengesWithNotNilValues() {
        // Given

        challengesAPIClientMock = ChallengesAPIClientMock()
        let challenges: [Challenge] = [Challenge]()
        challengesAPIClientMock.challenges = challenges
        ServiceLocator.shared.register(key: .challengesAPIClient, value: challengesAPIClientMock!)
        let viewModel = ChallengesViewModel(factorSid: "factorSid")
        let exp = expectation(description: "challenges should be called")

        // When

        viewModel.challenges.bind { _ in
            exp.fulfill()
        }

        viewModel.loadData()

        // then

        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail(exp.expectationDescription)
            } else {
                XCTAssertNotNil(viewModel.challenges.value, "challenges value should not be nil after excecuting it")
            }
        }
    }

    func testLoadDataWithErrorResultShouldTriggerShowAlertEvent() {
        // Given
        challengesAPIClientMock = ChallengesAPIClientMock()
        let error: TwAuthError = .invalidData
        challengesAPIClientMock.error = error
        ServiceLocator.shared.register(key: .challengesAPIClient, value: challengesAPIClientMock!)
        let viewModel = ChallengesViewModel(factorSid: "factorSid")
        let exp = expectation(description: "showAlert event should be called")

        // When

        viewModel.showAlert = { _ in
            exp.fulfill()
        }

        viewModel.loadData()

        // then

        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail(exp.expectationDescription)
            } else {
                XCTAssertNotNil(viewModel.showAlert, "showAlert should not be nil after excecuting it")
            }
        }
    }
}
