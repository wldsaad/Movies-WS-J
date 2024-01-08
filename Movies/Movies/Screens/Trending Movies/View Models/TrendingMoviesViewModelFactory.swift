//
//  TrendingMoviesViewModelFactory.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import Domain
import SwiftData
import Repository

struct TrendingMoviesViewModelFactory {
    
    @MainActor
    func viewModel() -> TrendingMoviesViewModel {
        let genresRepository: MovieGenresRepository = MovieGenresRepositoryImplementation(repository: RepositoryImplementation.shared)
        let trendingRepository: TrendingMoviesRepository = TrendingMoviesRepositoryImplementation(repository: RepositoryImplementation.shared)
        let genresUseCase: MovieGenresUseCase = MovieGenresUseCaseImplementation(repository: genresRepository)
        let trendingUseCase: TrendingMoviesUseCase = TrendingMoviesUseCaseImplementation(repository: trendingRepository)
        return TrendingMoviesViewModel(trendingMoviesUseCase: trendingUseCase, movieGenresUseCase: genresUseCase)
    }
}
