//
//  TrendingMoviesView.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import SwiftUI

struct TrendingMoviesView<ViewModel: TrendingMoviesViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
        
    var body: some View {
        let genresView = MovieGenresListView(genres: viewModel.genres)
        let moviesList = TrendingMoviesListView(movies: viewModel.movies)

        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section {
                    moviesList
                } header: {
                    genresView
                        .background(.regularMaterial)
                }
            }
        }
        .navigationTitle("Trending Movies")
        .searchable(text: $viewModel.searchValue, placement: .navigationBarDrawer(displayMode: .always))
        .overlay {
            if viewModel.movies.isEmpty, viewModel.moviesRequestStatus != .loading {
                if viewModel.searchValue.isEmpty {
                    ContentUnavailableView("No movies", systemImage: "film", description: Text("Check selected genres"))
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
    }
}

#Preview {
    TrendingMoviesView<TrendingMoviesViewModel>(
        viewModel: TrendingMoviesViewModelFactory().viewModel
    )
}
