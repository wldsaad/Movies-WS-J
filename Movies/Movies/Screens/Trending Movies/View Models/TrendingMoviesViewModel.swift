//
//  TrendingMoviesViewModel.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import Combine
import Domain

protocol TrendingMoviesViewModelProtocol: ObservableObject {
    
    var requestStatus: RequestStatus { get }
    
    var movies: [Movie] { get }
    
    func getMovies()
    
    func didReachMovie(_ movie: Movie)
}

class TrendingMoviesViewModel: TrendingMoviesViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var movies: [Movie] = []
    
    @Published var requestStatus: RequestStatus = .idle
    
    private var pagination = Pagination()
    
    private var trendingMoviesUseCase: TrendingMoviesUseCase

    private var isLoading = false
    
    // MARK: - Init
    
    init(trendingMoviesUseCase: TrendingMoviesUseCase) {
        self.trendingMoviesUseCase = trendingMoviesUseCase
        getMovies()
    }
    
    // MARK: - APIs
    
    func getMovies() {
        requestStatus = .loading
        Task {
            do {
                let response = try await trendingMoviesUseCase.execute(page: pagination.page + 1)
                self.pagination = response.pagination
                DispatchQueue.main.async { [weak self] in
                    self?.movies.append(contentsOf: response.movies.map(Movie.init))
                    self?.requestStatus = .success
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.requestStatus = .failure
                }
            }
        }
    }
    
    func didReachMovie(_ movie: Movie) {
        guard requestStatus != .loading,
              let index = movies.firstIndex(of: movie),
              index >= movies.endIndex - 1,
              pagination.totalPages > pagination.page else { return }
        
        getMovies()
    }
}
