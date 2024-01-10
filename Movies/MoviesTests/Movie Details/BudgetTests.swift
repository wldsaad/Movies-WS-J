//
//  BudgetTests.swift
//  MoviesTests
//
//  Created by Waleed Saad on 10/01/2024.
//

import XCTest
@testable import Movies

final class BudgetTests: XCTestCase {

    private var sut: MoneyTitleGenerator!
    
    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testBudgetTitle() throws {
        XCTAssertEqual(sut(0), "$0.00")
        XCTAssertEqual(sut(20), "$20.00")
        XCTAssertEqual(sut(1_000), "$1,000.00")
        XCTAssertEqual(sut(123_445), "$123,445.00")
        XCTAssertEqual(sut(3_123_445), "$3,123,445.00")
    }
}
