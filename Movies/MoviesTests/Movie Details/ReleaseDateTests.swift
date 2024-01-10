//
//  ReleaseDateTests.swift
//  MoviesTests
//
//  Created by Waleed Saad on 10/01/2024.
//

import XCTest
@testable import Movies

final class ReleaseDateTests: XCTestCase {

    private var sut: ReleaseDateTitleGenerator!
    
    private struct TestableDate {
        
        let year: Int
        let month: Int
        let validValue: String
    }
    
    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testReleaseDateTitle() throws {
        let yearsToTest: [TestableDate] = [
            .init(year: 2000, month: 2, validValue: "Feb 2000"),
            .init(year: 1900, month: 4, validValue: "Apr 1900"),
            .init(year: 2022, month: 9, validValue: "Sep 2022"),
            .init(year: 2023, month: 12, validValue: "Dec 2023"),
            .init(year: 2024, month: 1, validValue: "Jan 2024")
        ]
        
        var dateComponents = DateComponents()
        yearsToTest.forEach { testableYear in
            dateComponents.year = testableYear.year
            dateComponents.month = testableYear.month
            XCTAssertEqual(sut(Calendar.current.date(from: dateComponents)), String(testableYear.validValue))
        }
    }
}
