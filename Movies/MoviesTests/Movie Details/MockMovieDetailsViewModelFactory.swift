//
//  MockMovieDetailsUseCaseImplementation.swift
//  MoviesTests
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation
@testable import Movies
import Domain
import MockDataSource
import DataTransferObjects

struct MockMovieDetailsViewModelFactory {
    
    @MainActor
    func viewModel(movieId: Int) -> MovieDetailsViewModel {
        let movieDetailsUseCase: MovieDetailsUseCase = MockMovieDetailsUseCaseImplementation()
        let viewModel = MovieDetailsViewModel(movieId: movieId, movieDetailsUseCase: movieDetailsUseCase)
        return viewModel
    }
}

struct MockMovieDetailsUseCaseImplementation: MovieDetailsUseCase {
    
    private let repository = MockDataSource(json: "MovieDetails")

    mutating func execute(id: Int) async throws -> Domain.MovieDetails {
        let response: MovieDetailsResponse = try await repository.getData()
        return MovieDetailsDTOMapper(response: response)()
    }
}
