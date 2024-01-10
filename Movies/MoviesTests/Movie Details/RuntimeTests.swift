//
//  RuntimeTests.swift
//  MoviesTests
//
//  Created by Waleed Saad on 10/01/2024.
//

import XCTest
@testable import Movies

final class RuntimeTests: XCTestCase {

    private var sut: RuntimeTitleGenerator!
    
    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testRuntimeTitle() throws {
        XCTAssertEqual(sut(0), "0m")
        XCTAssertEqual(sut(20), "20m")
        XCTAssertEqual(sut(60), "1h")
        XCTAssertEqual(sut(80), "1h 20m")
        XCTAssertEqual(sut(120), "2h")
    }
}
