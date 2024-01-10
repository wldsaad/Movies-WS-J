//
//  MovieDetailsTests.swift
//  MoviesTests
//
//  Created by Waleed Saad on 10/01/2024.
//

import XCTest
@testable import Movies

@MainActor
final class MovieDetailsTests: XCTestCase {

    private var sut: MovieDetailsViewModel!
    
    override func setUpWithError() throws {
        sut = MockMovieDetailsViewModelFactory().viewModel(movieId: 1029575)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testMovieTitle() async throws {
        XCTAssertNil(sut.movie)
        try await sut.getMovieDetails()
        XCTAssertNotNil(sut.movie)
        XCTAssertEqual(sut.movie?.title, "The Family Plan")
        XCTAssertEqual(sut.movie?.releaseDate, "Dec 2023")
        XCTAssertEqual(sut.movie?.genres, "Action, Comedy")
        XCTAssertEqual(sut.movie?.overview, "Dan Morgan is many things: a devoted husband, a loving father, a celebrated car salesman. He's also a former assassin. And when his past catches up to his present, he's forced to take his unsuspecting family on a road trip unlike any other.")
        XCTAssertEqual(sut.movie?.homepage, "https://tv.apple.com/movie/umc.cmc.6o6y3wel2lez2tkdu2cv8dzd1")
        XCTAssertEqual(sut.movie?.spokenLanguages, "English")
        XCTAssertEqual(sut.movie?.status, "Released")
        XCTAssertEqual(sut.movie?.runtime, "1h 59m")
        XCTAssertEqual(sut.movie?.budget, "$0.00")
        XCTAssertEqual(sut.movie?.revenue, "$208.00")
    }
}
