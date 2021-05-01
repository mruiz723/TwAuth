//
//  AccessTokenOperationTests.swift
//  TwAuthTests
//
//  Created by Marlon David Ruiz Arroyave on 30/04/21.
//

import XCTest
@testable import TwAuth

class AccessTokenOperationTests: XCTestCase {

    private var networkSessionMock: NetworkSessionMock!

    override func setUpWithError() throws {
        networkSessionMock = NetworkSessionMock()
    }

    override func tearDownWithError() throws {
        networkSessionMock = nil
    }

    func testAccessTokenWithDataTriggersANewAccessToken() throws {
        // Given
        networkSessionMock.data = accessTokenResponseData
        let loginOperation = LoginOperation()
        loginOperation.account?.id = "id"
        let accessTokenOperation = AccessTokenOperation(session: networkSessionMock)
        accessTokenOperation.endpoint = Endpoint.accessToken()
        accessTokenOperation.addDependency(loginOperation)

        // When
        accessTokenOperation.main()

        // Then
        XCTAssertNotNil(accessTokenOperation.account?.accessToken, "accesToken should no be nil")
    }

    func testAccessTokenWithNoDataNoTriggersANewAccessToken() throws {
        // Given...,,,,
        let loginOperation = LoginOperation()
        loginOperation.account?.id = "id"
        let accessTokenOperation = AccessTokenOperation(session: networkSessionMock)
        accessTokenOperation.endpoint = Endpoint.accessToken()
        accessTokenOperation.addDependency(loginOperation)

        // When
        accessTokenOperation.main()

        // Then
        XCTAssertNil(accessTokenOperation.account?.accessToken, "accesToken should be nil")
    }

    private var accessTokenResponseData: Data? {
        let jsonString = """
            {
                "token": "Taylor Swift",
                "serviceSid": "fdjaskfdj13243",
                "identity": "identity",
                "factorType": "factorType"
            }
        """

        return Data(jsonString.utf8)
    }
}
