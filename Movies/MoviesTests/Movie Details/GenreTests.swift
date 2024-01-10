//
//  GenreTests.swift
//  MoviesTests
//
//  Created by Waleed Saad on 10/01/2024.
//

import XCTest
@testable import Movies

final class GenreTests: XCTestCase {

    private var sut: GenreTitleGenerator!
    
    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGenreTitle() throws {
        XCTAssertEqual(sut([
            .init(id: 1, name: "Action")
        ]), "Action")
        
        XCTAssertEqual(sut([
            .init(id: 1, name: "Action"),
            .init(id: 2, name: "Comedy")
        ]), "Action, Comedy")
        
        XCTAssertEqual(sut([
            .init(id: 1, name: "Action"),
            .init(id: 2, name: "Comedy"),
            .init(id: 2, name: "Adventure")
        ]), "Action, Comedy, Adventure")
    }
}
