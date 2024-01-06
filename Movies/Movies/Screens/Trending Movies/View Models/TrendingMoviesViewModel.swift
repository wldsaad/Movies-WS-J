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
    
    var moviesRequestStatus: RequestStatus { get }
    
    var movieGenresRequestStatus: RequestStatus { get }
    
    var searchValue: String { get set }
    
    var movies: [Movie] { get }
    
    var genres: [Genre] { get }
    
    func didTapGenre(_ genre: Genre)
    
    func didReachMovie(_ movie: Movie)
}

class TrendingMoviesViewModel: TrendingMoviesViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var movies: [Movie] = []
    
    @Published var genres: [Genre] = []
    
    @Published var searchValue: String = ""
    
    @Published var moviesRequestStatus: RequestStatus = .idle
    
    @Published var movieGenresRequestStatus: RequestStatus = .idle
    
    private var allMovies: [Movie] = []

    private var pagination = Pagination()
    
    private var trendingMoviesUseCase: TrendingMoviesUseCase
    
    private var movieGenresUseCase: MovieGenresUseCase

    private var isLoading = false
    
    private var searchValueCancellable = Set<AnyCancellable>()

    // MARK: - Init
    
    init(
        trendingMoviesUseCase: TrendingMoviesUseCase,
        movieGenresUseCase: MovieGenresUseCase
    ) {
        self.trendingMoviesUseCase = trendingMoviesUseCase
        self.movieGenresUseCase = movieGenresUseCase
        getGenres()
        getMovies()
        
        $searchValue
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.didChangeSearch(value)
            })
            .store(in: &searchValueCancellable)
    }
    
    // MARK: - APIs
    
    func didTapGenre(_ genre: Genre) {
        genres.forEach { currentGenre in
            if genre == currentGenre {
                currentGenre.selected.toggle()
            } else {
                currentGenre.selected = false
            }
        }
    }
    
    func didReachMovie(_ movie: Movie) {
        guard moviesRequestStatus != .loading,
              let index = movies.firstIndex(of: movie),
              index >= movies.endIndex - 1,
              pagination.totalPages > pagination.page,
              searchValue.isEmpty else { return }
        
        getMovies()
    }
    
    func didChangeSearch(_ search: String) {
        guard !search.isEmpty else {
            movies = allMovies
            return
        }
        
        let moviesPredicate = #Predicate<Movie> { movie in
            movie.title.localizedLowercase.contains(search.localizedLowercase)
        }
        
        let filteredMovies = try? allMovies.filter(moviesPredicate)
        movies = filteredMovies ?? allMovies
    }
    
    // MARK: - Methods
    
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
    
    private func getMovies() {
        moviesRequestStatus = .loading
        Task {
            do {
                let response = try await trendingMoviesUseCase.execute(page: pagination.page + 1)
                self.pagination = response.pagination
                DispatchQueue.main.async { [weak self] in
                    self?.movies.append(contentsOf: response.movies.map(Movie.init))
                    self?.allMovies = self?.movies ?? []
                    self?.moviesRequestStatus = .success
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.moviesRequestStatus = .failure
                }
            }
        }
    }
}
