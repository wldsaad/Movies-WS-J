//
//  MovieDetailsViewModelFactory.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation
import Domain
import Repository

struct MovieDetailsViewModelFactory {
    
    @MainActor
    func viewModel(movieId: Int) -> MovieDetailsViewModel {
        let repository: MovieDetailsRepository = MovieDetailsRepositoryImplementation(repository: RepositoryImplementation.shared)
        let movieDetailsUseCase: MovieDetailsUseCase = MovieDetailsUseCaseImplementation(repository: repository)
        let viewModel = MovieDetailsViewModel(movieId: movieId, movieDetailsUseCase: movieDetailsUseCase)
        return viewModel
    }
}
