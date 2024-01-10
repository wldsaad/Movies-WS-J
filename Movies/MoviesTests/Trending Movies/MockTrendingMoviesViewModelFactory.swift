//
//  MockTrendingMoviesViewModelFactory.swift
//  MoviesTests
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation
@testable import Movies
import Domain
import DataTransferObjects
import MockDataSource

struct MockTrendingMoviesViewModelFactory {
    
    @MainActor
    func viewModel() -> TrendingMoviesViewModel {
        let genresUseCase: MovieGenresUseCase = MovieGenresUseCaseImplementation(repository: MockMovieGenresRepositoryImplementation())
        let trendingUseCase: TrendingMoviesUseCase = TrendingMoviesUseCaseImplementation(repository: MockTrendingMoviesRepositoryImplementation())
        return TrendingMoviesViewModel(trendingMoviesUseCase: trendingUseCase, movieGenresUseCase: genresUseCase)
    }
}

struct MockMovieGenresRepositoryImplementation: MovieGenresRepository {
    
    private let repository = MockDataSource(json: "MovieGenres")
    
    // MARK: - APIs
    
    mutating public func execute() async throws -> MovieGenres {
        let response: MovieGenresResponse = try await repository.getData()
        return MovieGenresDTOMapper(response: response)()
    }
}

struct MockTrendingMoviesRepositoryImplementation: TrendingMoviesRepository {
    
    private let repository = MockDataSource(json: "TrendingMovies")

    // MARK: - APIs
    
    mutating public func execute(page: Int) async throws -> TrendingMovies {
        let response: TrendingMoviesResponse = try await repository.getData()
        return TrendingMoviesDTOMapper(response: response)()
    }
}
