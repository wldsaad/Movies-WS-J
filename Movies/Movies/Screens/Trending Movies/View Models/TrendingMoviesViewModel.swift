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
    
    var lastUpdatedDate: Date { get }
    
    func getCachedData() async throws
    
    func getGenres() async throws
    
    func getMovies() async throws
    
    func didTapGenre(_ genre: Genre)
    
    func didReachMovie(_ movie: Movie)
}

@MainActor
class TrendingMoviesViewModel: TrendingMoviesViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var movies: [Movie] = []
    
    @Published var genres: [Genre] = []
    
    @Published var searchValue: String = ""
    
    @Published var moviesRequestStatus: RequestStatus = .idle
    
    @Published var movieGenresRequestStatus: RequestStatus = .idle
    
    @Published var lastUpdatedDate = Date()

    var allMovies: [Movie] = []

    var pagination = MoviesPagination(Pagination())

    var isLoading = false

    var selectedGenreIds: [Int] {
        genres.filter { $0.selected }.map { $0.id }
    }
    
    private var searchValueCancellable = Set<AnyCancellable>()
    
    private var trendingMoviesUseCase: TrendingMoviesUseCase
    
    private var movieGenresUseCase: MovieGenresUseCase
    
    // MARK: - Init
    
    init(
        trendingMoviesUseCase: TrendingMoviesUseCase,
        movieGenresUseCase: MovieGenresUseCase
    ) {
        self.trendingMoviesUseCase = trendingMoviesUseCase
        self.movieGenresUseCase = movieGenresUseCase
        
        $searchValue
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.setFilteredMovies()
            })
            .store(in: &searchValueCancellable)
    }
    
    // MARK: - APIs
    
    func getCachedData() async throws {
        try getCachedGenres()
        try getCachedMovies()
        try getCachedPagination()
    }
    
    func getGenres() async throws {
        movieGenresRequestStatus = .loading
        let response = try await movieGenresUseCase.execute()
        genres = response.map(Genre.init)
        movieGenresRequestStatus = .success
        try cacheGenres()
    }
    
    func getMovies() async throws {
        try await getMovies(pagination: MoviesPagination(Pagination()))
    }
    
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
        
        Task {
            do {
                try await getMovies(pagination: pagination)
            } catch {
                movieGenresRequestStatus = .failure
            }
        }
    }
        
    // MARK: - Methods
        
    private func getMovies(pagination: MoviesPagination) async throws {
        moviesRequestStatus = .loading
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
        try cacheMovies()
        try cachePagination()
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
        
        lastUpdatedDate = Date()
    }
    
    // MARK: - Cache
    
    private func getCachedGenres() throws {
        let cachedGenres: [Genre] = try LocalDataContainer.shared.getCached(sortBy: [
            SortDescriptor(\.createdAt, order: .forward)
        ])
        genres = cachedGenres
    }
    
    private func getCachedMovies() throws {
        let cachedMovies: [Movie] = try LocalDataContainer.shared.getCached(sortBy: [
            SortDescriptor(\.createdAt, order: .forward)
        ])
        movies = cachedMovies
        allMovies = cachedMovies
    }
    
    private func getCachedPagination() throws {
        if let pagination: MoviesPagination = try LocalDataContainer.shared.getCached().last {
            self.pagination = pagination
        }
    }
    
    private func cacheMovies() throws {
        try LocalDataContainer.shared.replaceAll(allMovies)
    }
    
    private func cachePagination() throws {
        try LocalDataContainer.shared.replaceAll([pagination])
    }
    
    private func cacheGenres() throws {
        try LocalDataContainer.shared.replaceAll(genres)
    }
}
