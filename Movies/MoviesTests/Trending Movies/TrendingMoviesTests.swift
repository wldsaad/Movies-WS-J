//
//  TrendingMoviesTests.swift
//  MoviesTests
//
//  Created by Waleed Saad on 04/01/2024.
//

import XCTest
@testable import Movies

@MainActor
final class TrendingMoviesTests: XCTestCase {

    private var sut: TrendingMoviesViewModel!
    
    override func setUpWithError() throws {
        sut = MockTrendingMoviesViewModelFactory().viewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testPagination() throws {
        XCTAssertEqual(sut.pagination.currentPage, 0)
    }
    
    func testEmptyMovies() throws {
        XCTAssertTrue(sut.allMovies.isEmpty)
        XCTAssertTrue(sut.movies.isEmpty)
    }
    
    func testEmptyGenres() throws {
        XCTAssertTrue(sut.genres.isEmpty)
        XCTAssertTrue(sut.selectedGenreIds.isEmpty)
    }
    
    func testMovies() async throws {
        XCTAssertTrue(sut.movies.isEmpty)
        try await sut.getMovies()
        let movies = sut.movies
        XCTAssertFalse(movies.isEmpty)
        
        XCTAssertEqual(movies.count, 20)
        XCTAssertEqual(movies.first?.id, 1029575)
        XCTAssertEqual(movies.first?.title, "The Family Plan")
        XCTAssertEqual(movies.first?.thumbnail, "https://image.tmdb.org/t/p/w300/r9oTasGQofvkQY5vlUXglneF64Z.jpg")
        XCTAssertEqual(movies.first?.releaseDate, "2023")
        XCTAssertEqual(movies.first?.genreIds, [28, 35])
        
        XCTAssertEqual(movies.last?.id, 1075794)
        XCTAssertEqual(movies.last?.title, "Leo")
        XCTAssertEqual(movies.last?.thumbnail, "https://image.tmdb.org/t/p/w300/9PqD3wSIjntyJDBzMNuxuKHwpUD.jpg")
        XCTAssertEqual(movies.last?.releaseDate, "2023")
        XCTAssertEqual(movies.last?.genreIds, [16, 35, 10751])
    }
    
    func testSearchNonEmptyValue() async throws {
        try await executeSearchTest(for: "The Family Plan", expectedCount: 1)
        try await executeSearchTest(for: "The Family plan", expectedCount: 1)
        try await executeSearchTest(for: "The family Plan", expectedCount: 1)
        try await executeSearchTest(for: "the Family plan", expectedCount: 1)
        try await executeSearchTest(for: "the family Plan", expectedCount: 1)
        try await executeSearchTest(for: "the family plan", expectedCount: 1)
        try await executeSearchTest(for: "The Family", expectedCount: 1)
        try await executeSearchTest(for: "The family", expectedCount: 1)
        try await executeSearchTest(for: "the Family", expectedCount: 1)
        try await executeSearchTest(for: "the family", expectedCount: 1)
        try await executeSearchTest(for: "Family", expectedCount: 1)
        try await executeSearchTest(for: "family", expectedCount: 1)
        try await executeSearchTest(for: "", expectedCount: 20)
    }
    
    func testMovieGenres() async throws {
        XCTAssertTrue(sut.genres.isEmpty)
        try await sut.getGenres()
        let genres = sut.genres
        XCTAssertFalse(genres.isEmpty)
        XCTAssertEqual(genres.count, 19)
        XCTAssertEqual(genres.first?.name, "Action")
        XCTAssertEqual(genres.last?.name, "Western")
    }
    
    func testSelect_UnselectGenres() async throws {
        XCTAssertTrue(sut.movies.isEmpty)
        try await sut.getGenres()
        try await sut.getMovies()
        
        // Select action genre
        try await executeGenreSelection(at: [0], expectedResult: 9)
        // Deselect action genre
        try await executeGenreDeselection(at: [0], expectedResult: 20)
        // Select animation genre
        try await executeGenreSelection(at: [2], expectedResult: 1)
        // Deselect animation genre
        try await executeGenreDeselection(at: [2], expectedResult: 20)
        // Select action & animation genres
        try await executeGenreSelection(at: [0, 2], expectedResult: 10)
        // Deselect action & animation genres
        try await executeGenreDeselection(at: [0, 2], expectedResult: 20)
    }
    
    private func executeSearchTest(for value: String, expectedCount: Int) async throws {
        let expectation = expectation(description: "Search debounce by 0.5 sec")
        try await sut.getMovies()
        sut.searchValue = value
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 0.6)
        XCTAssertEqual(sut.movies.count, expectedCount)
    }
    
    private func executeGenreSelection(at indices: [Int], expectedResult: Int) async throws {
        indices.forEach { sut.didTapGenre(sut.genres[$0]) }
        XCTAssertEqual(sut.selectedGenreIds, indices.map { sut.genres[$0].id} )
        XCTAssertEqual(sut.movies.count, expectedResult)
    }
    
    private func executeGenreDeselection(at indices: [Int], expectedResult: Int) async throws {
        indices.forEach { sut.didTapGenre(sut.genres[$0]) }
        XCTAssertEqual(sut.selectedGenreIds, [])
        XCTAssertEqual(sut.movies.count, expectedResult)
    }
}
