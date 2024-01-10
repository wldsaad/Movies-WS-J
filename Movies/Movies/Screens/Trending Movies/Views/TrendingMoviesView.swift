//
//  TrendingMoviesView.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import SwiftUI

struct TrendingMoviesView<ViewModel: TrendingMoviesViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var didFinishSetup = false
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
        
    var body: some View {
        let genresView = MovieGenresListView(genres: $viewModel.genres)
        let moviesList = TrendingMoviesListView(movies: $viewModel.movies)
        
        ZStack(alignment: .top) {
            ScrollView {
                moviesList
                    .id(viewModel.lastUpdatedDate)
            }
            
            genresView
                .background(.regularMaterial)
        }
        
        .navigationTitle("Trending Movies")
        .searchable(text: $viewModel.searchValue, placement: .navigationBarDrawer(displayMode: .always))
        .overlay {
            if viewModel.movies.isEmpty, viewModel.moviesRequestStatus != .loading {
                if viewModel.searchValue.isEmpty {
                    ContentUnavailableView("No movies", systemImage: "film")
                } else {
                    ContentUnavailableView.search(text: viewModel.searchValue)
                }
            }
        }
        .onReceive(moviesList.didReachMovie) { movie in
            viewModel.didReachMovie(movie)
        }
        .onReceive(genresView.didTapGenre) { genre in
            withAnimation {
                viewModel.didTapGenre(genre)
            }
        }
        .onAppear {
            if !didFinishSetup {
                Task {
                    do {
                        try await viewModel.getCachedData()
                        try await viewModel.getGenres()
                        try await viewModel.getMovies()
                    } catch {}
                }
                didFinishSetup = true
            }
        }
    }
}
