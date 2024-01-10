//
//  SpokenLanguagesTests.swift
//  MoviesTests
//
//  Created by Waleed Saad on 10/01/2024.
//

import XCTest
@testable import Movies

final class SpokenLanguagesTests: XCTestCase {

    private var sut: SpokenLanguagesTitleGenerator!
    
    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSpokenLanguagesTitle() throws {
        XCTAssertEqual(sut([
            .init(name: "English")
        ]), "English")

        XCTAssertEqual(sut([
            .init(name: "English"),
            .init(name: "Spanish")
        ]), "English, Spanish")
    }
}
