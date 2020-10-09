//
//  EventListViewModelTests.swift
//  GithubEventsTests
//
//  Created by João Palma on 01/10/2020.
//

import XCTest
import RxSwift
@testable import GithubEvents

class EventListViewModelTests: XCTestCase {
    let eventListViewModel: EventListViewModel = DiContainer.resolve()

    func testRxEventsCountMustBe30() throws {
        eventListViewModel.initialize()

        eventListViewModel.events.subscribe(onNext: { events in
            if !self.eventListViewModel.isFetching {
                XCTAssert(events.count == 30)
            }
        }).dispose()
    }

    func testIfEventsIsNotFiltering() throws {
        eventListViewModel.isFiltering.subscribe { event in
            XCTAssert(event.element == false)
        }.dispose()
    }
}
