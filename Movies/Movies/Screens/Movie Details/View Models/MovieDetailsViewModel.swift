//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation
import Domain

@MainActor
protocol MovieDetailsViewModelProtocol: ObservableObject {
    
    var movie: MovieDetails? { get }
    
    var moviesRequestStatus: RequestStatus { get }
}

@MainActor
class MovieDetailsViewModelImplementation: MovieDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var movie: MovieDetails?
    
    @Published var moviesRequestStatus: RequestStatus = .idle
    
    private var movieDetailsUseCase: MovieDetailsUseCase
    
    private let movieId: Int
    
    // MARK: - Init
    
    init(movieId: Int, movieDetailsUseCase: MovieDetailsUseCase) {
        self.movieId = movieId
        self.movieDetailsUseCase = movieDetailsUseCase
        
        getMovieDetails()
    }
    
    // MARK: - Methods
    
    private func getMovieDetails() {
        moviesRequestStatus = .loading
        Task {
            do {
                let response = try await movieDetailsUseCase.execute(id: movieId)
                movie = .init(movie: response)
                moviesRequestStatus = .success
            } catch {
                moviesRequestStatus = .failure
            }
        }
    }
}
