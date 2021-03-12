//
//  MobileServiceTests.swift
//  FetchExerciseTests
//
//  Created by Jon Duenas on 3/12/21.
//

import XCTest
@testable import FetchExercise
import Mocker

class MobileServiceTests: XCTestCase {
    
    var sut: MobileService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = URLSession(configuration: configuration)
        
        sut = MobileService(sessionManager: sessionManager)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchEvents() throws {
        let expectedEvent = Event(id: 5039740,
                                  title: "NHRA Gatornationals Thursday Only",
                                  shortTitle: "NHRA Gatornationals Thursday Only",
                                  url: URL(string: "https://seatgeek.com/nhra-gatornationals-thursday-only-tickets/nascar/2021-03-12-3-30-am/5039740")!,
                                  images: [.huge: "https://seatgeek.com/images/performers-landscape/nhra-gatornationals-6f2f64/14498/huge.jpg"],
                                  dateTimeLocal: .dateTime(date: "Friday, March 12, 2021", time: "3:30 AM"),
                                  city: "Gainesville",
                                  state: "FL",
                                  country: "US")
        let requestExpectation = expectation(description: "Request should finish")
        
        let eventsEndpoint = sut.api_endpoint.appendingPathComponent(apiResource.events.rawValue)
        let mock = Mock(url: eventsEndpoint, ignoreQuery: true, dataType: .json, statusCode: 200, data: [.get: try Data(contentsOf: MockedData.mockJSON)])
        mock.register()
        
        sut.fetchEvents(page: 1, query: nil, ids: nil) { result in
            defer { requestExpectation.fulfill() }
            switch result {
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            case .success(let events):
                XCTAssertEqual(events[0].title, expectedEvent.title)
                XCTAssertEqual(events[0].dateTimeLocal, expectedEvent.dateTimeLocal)
            }
        }
        
        wait(for: [requestExpectation], timeout: 5.0)
    }

    func testFetchEvents_WithError() throws {
        let requestExpectation = expectation(description: "Request should finish")
        
        enum TestError: Error, LocalizedError {
            case error
            
            var errorDescription: String { "test" }
        }
        
        let eventsEndpoint = sut.api_endpoint.appendingPathComponent(apiResource.events.rawValue)
        let mock = Mock(url: eventsEndpoint, ignoreQuery: true, dataType: .json, statusCode: 500, data: [.get: Data()], requestError: TestError.error)
        mock.register()
        
        sut.fetchEvents(page: 1, query: nil, ids: nil) { result in
            defer { requestExpectation.fulfill() }
            switch result {
            case .failure(let error):
                XCTAssertTrue(String(describing: error).contains("TestError"))
            case .success(_):
                XCTFail()
            }
        }
        
        wait(for: [requestExpectation], timeout: 5.0)
    }
    
    func testFetchEvents_WithParameters() throws {
        let requestExpectation = expectation(description: "Request should finish")
        let mockExpectation = expectation(description: "The get content list mock should be called")
        let eventsEndpoint = sut.api_endpoint.appendingPathComponent(apiResource.events.rawValue)
        
        let testQuery = "houston"
        let testPage = 4
        let ids = [1234,5678,9101112]
        let idsString = "1234,5678,9101112"
        
        var mock = Mock(url: eventsEndpoint, ignoreQuery: true, dataType: .json, statusCode: 200, data: [.get: try Data(contentsOf: MockedData.mockJSON)])

        mock.onRequest = { request, _ in
            let urlWithoutQuery = request.url?.absoluteString.replacingOccurrences(of: request.url!.query!, with: "")
            XCTAssertEqual(urlWithoutQuery, "https://api.seatgeek.com/2/events?")

            XCTAssertEqual(request.url?.query, "client_id=MjE1ODQ0MDN8MTYxNTMyNTUwOC45ODI4ODA0&id=\(idsString)&page=\(testPage)&per_page=20&q=\(testQuery)")

            mockExpectation.fulfill()
        }
        mock.register()
        
        sut.fetchEvents(page: testPage, query: testQuery, ids: ids) { result in
            requestExpectation.fulfill()
        }
        
        wait(for: [mockExpectation, requestExpectation], timeout: 5.0)
    }
}
