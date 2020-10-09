//
//  GithubEventsTests.swift
//  GithubEventsTests
//
//  Created by João Palma on 23/09/2020.
//

import XCTest
@testable import GithubEvents

class EventWebServiceTests: XCTestCase {

    let eventWebService: EventWebService = DiContainer.resolve()

    func testFetchedEventListCountMustBe30() throws {
        _ = eventWebService.getEvents { result in
            if case .success(let eventStructList) = result {
                XCTAssert(eventStructList?.count == 30)
            }
        }
    }
}
