//
//  TrendingMoviesViewModelFactory.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import Domain
import Repository

struct TrendingMoviesViewModelFactory {
    
    var viewModel: TrendingMoviesViewModel {
        let trendingRepository: TrendingMoviesRepository = DefaultTrendingMoviesRepository(repository: DefaultRepository.shared.repository)
        let trendingUseCase: TrendingMoviesUseCase = DefaultTrendingMoviesUseCase(repository: trendingRepository)
        return TrendingMoviesViewModel(trendingMoviesUseCase: trendingUseCase)
    }
}
