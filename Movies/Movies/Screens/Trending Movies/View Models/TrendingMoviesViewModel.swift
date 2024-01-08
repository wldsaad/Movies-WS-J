//
//  TrendingMoviesViewModel.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import Combine
import SwiftData
import Domain

@MainActor
protocol TrendingMoviesViewModelProtocol: ObservableObject {
    
    var moviesRequestStatus: RequestStatus { get }
    
    var movieGenresRequestStatus: RequestStatus { get }
    
    var searchValue: String { get set }
    
    var movies: [Movie] { get set }
    
    var genres: [Genre] { get set }
    
    func didTapGenre(_ genre: Genre)
    
    func didReachMovie(_ movie: Movie)
}

@MainActor
class TrendingMoviesViewModel: TrendingMoviesViewModelProtocol {
    
    // MARK: - Properties
    
    var movies: [Movie] = []
    
    var genres: [Genre] = []
    
    @Published var searchValue: String = ""
    
    @Published var moviesRequestStatus: RequestStatus = .idle
    
    @Published var movieGenresRequestStatus: RequestStatus = .idle
    
    private var allMovies: [Movie] = []

    private var pagination = MoviesPagination(Pagination())
    
    private var trendingMoviesUseCase: TrendingMoviesUseCase
    
    private var movieGenresUseCase: MovieGenresUseCase

    private var isLoading = false

    private var selectedGenreIds: [Int] {
        genres.filter { $0.selected }.map { $0.id }
    }
    
    private var searchValueCancellable = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(
        trendingMoviesUseCase: TrendingMoviesUseCase,
        movieGenresUseCase: MovieGenresUseCase
    ) {
        self.trendingMoviesUseCase = trendingMoviesUseCase
        self.movieGenresUseCase = movieGenresUseCase
        getCachedData()
        getGenres()
        getMovies(pagination: MoviesPagination(Pagination()))
        
        $searchValue
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.setFilteredMovies()
            })
            .store(in: &searchValueCancellable)
    }
    
    // MARK: - APIs
    
    func didTapGenre(_ genre: Genre) {
        genre.selected.toggle()
        setFilteredMovies()
    }
    
    func didReachMovie(_ movie: Movie) {
        guard moviesRequestStatus != .loading,
              let index = movies.firstIndex(of: movie),
              index >= movies.endIndex - 1,
              pagination.totalPages > pagination.currentPage,
              searchValue.isEmpty,
              selectedGenreIds.isEmpty else { return }
        
        getMovies(pagination: pagination)
    }
        
    // MARK: - Network Requests

    private func getGenres() {
        movieGenresRequestStatus = .loading
        Task {
            do {
                let response = try await movieGenresUseCase.execute()
                DispatchQueue.main.async { [weak self] in
                    self?.genres = response.map(Genre.init)
                    self?.movieGenresRequestStatus = .success
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.movieGenresRequestStatus = .failure
                }
            }
        }
    }
        
    private func getMovies(pagination: MoviesPagination) {
        moviesRequestStatus = .loading
        Task {
            do {
                let pageToRequest = pagination.currentPage + 1
                let response = try await trendingMoviesUseCase.execute(page: pageToRequest)
                let moviesResponse = response.movies.map(Movie.init)
                if pageToRequest > 1 {
                    movies.append(contentsOf: moviesResponse)
                } else {
                    movies = moviesResponse
                }
                allMovies = movies
                moviesRequestStatus = .success
                self.pagination = .init(response.pagination)
                try cacheResponse()
            } catch {
                moviesRequestStatus = .failure
            }
        }
    }
    
    // MARK: - Filter

    private func setFilteredMovies() {
        movies = {
            let selectedGenreIds = Set(selectedGenreIds)
            
            if searchValue.isEmpty, selectedGenreIds.isEmpty { return allMovies }
            
            return allMovies.filter { movie in
                let searchPredicate = searchValue.isEmpty ? true : movie.title.localizedStandardContains(searchValue)
                let genrePredicate = selectedGenreIds.isEmpty ? true : !Set(selectedGenreIds).isDisjoint(with: Set(movie.genreIds))
                
                return searchPredicate && genrePredicate
            }
        }()
    }
    
    // MARK: - Cache
    
    private func getCachedData() {
        do {
            try getCachedGenres()
            try getCachedMovies()
            try getCachedPagination()
        } catch {}
    }
    
    private func getCachedGenres() throws {
        do {
            genres = try LocalDataContainer.shared.getCached()
        } catch { throw error }
    }
    
    private func getCachedMovies() throws {
        do {
            let cachedMovies: [Movie] = try LocalDataContainer.shared.getCached(sortBy: [
                SortDescriptor(\.createdAt, order: .forward)
            ])
            movies = cachedMovies
            allMovies = cachedMovies
        } catch { throw error }
    }
    
    private func getCachedPagination() throws {
        do {
            if let pagination: MoviesPagination = try LocalDataContainer.shared.getCached().last {
                self.pagination = pagination
            }
        } catch { throw error }
    }
    
    private func cacheResponse() throws {
        let cachedMovies: [Movie] = try LocalDataContainer.shared.getCached()
        let cachedMoviesDictionary = cachedMovies.reduce(into: [:]) { partialResult, movie in
            partialResult[movie.id] = movie
        }
        let uniqueMovies = allMovies.filter { cachedMoviesDictionary[$0.id] == nil }
        try LocalDataContainer.shared.insert(uniqueMovies)
        
        try LocalDataContainer.shared.deleteAll(MoviesPagination.self)
        try LocalDataContainer.shared.insert(pagination)
    }
}
