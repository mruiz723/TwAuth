//
//  ChallengeDetailViewModelTests.swift
//  TwAuthTests
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

import XCTest
@testable import TwAuth
import MRCommons

class ChallengeDetailViewModelTests: XCTestCase {

    private var challengeAPIClientMock: ChallengeAPIClientMock!

    func testInit() {
        let viewModel = ChallengeDetailViewModel(factorSid: "factorSid", challengeSid: "challengeSid")
        XCTAssertNil(viewModel.challenge.value, "challenges value should be nil")
    }

    func testViewDidLoadWithErrorResultShouldTriggerShowAlertEvent() {
        // Given

        challengeAPIClientMock = ChallengeAPIClientMock()
        let error: TwAuthError = .invalidData
        challengeAPIClientMock.error = error
        ServiceLocator.shared.register(key: .challengeAPIClient, value: challengeAPIClientMock!)
        let viewModel = ChallengeDetailViewModel(factorSid: "factorSid", challengeSid: "challengeSid")
        let exp = expectation(description: "showAlert event should be called")

        // When

        viewModel.showAlert = { _ in
            exp.fulfill()
        }

        viewModel.viewDidLoad()

        // then

        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail(exp.expectationDescription)
            } else {
                XCTAssertNotNil(viewModel.showAlert, "showAlert should not be nil after excecuting it")
            }
        }
    }

    func testUpdateChallengeWithErrorResultShouldTriggerShowAlertEvent() {
        // Given

        challengeAPIClientMock = ChallengeAPIClientMock()
        let error: TwAuthError = .invalidData
        challengeAPIClientMock.error = error
        ServiceLocator.shared.register(key: .challengeAPIClient, value: challengeAPIClientMock!)
        let viewModel = ChallengeDetailViewModel(factorSid: "factorSid", challengeSid: "challengeSid")
        let exp = expectation(description: "showAlert event should be called")

        // When

        viewModel.showAlert = { _ in
            exp.fulfill()
        }

        viewModel.updateChallenge(withStatus: .approved)

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
