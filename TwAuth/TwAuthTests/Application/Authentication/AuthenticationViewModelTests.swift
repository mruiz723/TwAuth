//
//  AuthenticationViewModelTests.swift
//  TwAuthTests
//
//  Created by Marlon David Ruiz Arroyave on 17/02/21.
//

import XCTest
@testable import TwAuth
import MRCommons

class AuthenticationViewModelTests: XCTestCase {

    private var authenticationManagerMock: AuthenticationManagerMock!

    override func setUpWithError() throws {
        authenticationManagerMock = AuthenticationManagerMock()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        authenticationManagerMock = nil
    }

    func testInit() {
        let viewModel = AuthenticationViewModel(authenticationManager: authenticationManagerMock)
        XCTAssertFalse(viewModel.isSubmitButtonEnabled.value, "isSubmitButtonEnabled should be false")
    }

    func testTextFieldDidChangeWithDataNameTextFieldNameShouldTriggerIsSubmitButtonEnableWithFalseValue() {
        // Given

        let viewModel = AuthenticationViewModel(authenticationManager: authenticationManagerMock)

        // When

        viewModel.textFieldDidChange(with: Constants.name, nameTextField: .name)

        // then

        XCTAssertFalse(viewModel.isSubmitButtonEnabled.value, "isSubmitButtonEnabled should be false since the password length is zero")
    }

    func testTextFieldDidChangeWithDataPasswordTextFieldNameShouldTriggerIsSubmitButtonEnableWithFalseValue() {
        // Given

        let viewModel = AuthenticationViewModel(authenticationManager: authenticationManagerMock)

        // When

        viewModel.textFieldDidChange(with: Constants.password, nameTextField: .password)

        // then

        XCTAssertFalse(viewModel.isSubmitButtonEnabled.value, "isSubmitButtonEnabled should be false since the name length is zero")
    }

    func testTextFieldDidChangeWithDataInNameAndPasswordShouldTriggerIsSubmitButtonEnableWithTrueValue() {
        // Given

        let viewModel = AuthenticationViewModel(authenticationManager: authenticationManagerMock)

        // When

        viewModel.textFieldDidChange(with: Constants.name, nameTextField: .name)
        viewModel.textFieldDidChange(with: Constants.password, nameTextField: .password)

        // then

        XCTAssertTrue(viewModel.isSubmitButtonEnabled.value, "isSubmitButtonEnabled should be true since the name and password length are not zero")
    }

    func testDidTapLoginButtonWithAccountResultShouldTriggerShowChallengesEvent() {
        // Given

        let accessToken: AccessTokenResponse = AccessTokenResponse(token: "token", serviceSid: "serviceSid", identity: "identity", factorType: "factorType")
        let account: Account = Account(id: Constants.id, accessToken: accessToken, factorSid: "factorSid")
        authenticationManagerMock.account = account
        let viewModel = AuthenticationViewModel(authenticationManager: authenticationManagerMock)
        let exp = expectation(description: "showChallenges event should be called")

        // When

        viewModel.showChallenges = { _ in
            exp.fulfill()
        }

        viewModel.didTapLoginButton()

        // then

        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail(exp.expectationDescription)
            } else {
                XCTAssertNotNil(viewModel.showChallenges, "showChallenges should not be nil after excecuting it")
            }
        }
    }

    func testDidTapLoginButtonWithErrorResultShouldTriggerShowAlertEvent() {
        // Given

        let error: TwAuthError = .invalidData
        authenticationManagerMock.error = error
        let viewModel = AuthenticationViewModel(authenticationManager: authenticationManagerMock)
        let exp = expectation(description: "showAlert event should be called")

        // When

        viewModel.showAlert = { _ in
            exp.fulfill()
        }

        viewModel.didTapLoginButton()

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
