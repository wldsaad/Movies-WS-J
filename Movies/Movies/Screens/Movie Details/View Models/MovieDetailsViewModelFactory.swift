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
    func viewModel(movieId: Int) -> MovieDetailsViewModelImplementation {
        let repository: MovieDetailsRepository = MovieDetailsRepositoryImplementation(repository: DefaultRepository.shared.repository)
        let movieDetailsUseCase: MovieDetailsUseCase = MovieDetailsUseCaseImplementation(repository: repository)
        let viewModel = MovieDetailsViewModelImplementation(movieId: movieId, movieDetailsUseCase: movieDetailsUseCase)
        return viewModel
    }
}
