//
//  TrendingMoviesView.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import SwiftUI

struct TrendingMoviesView<ViewModel: TrendingMoviesViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var search = ""
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    private let columns = (0..<2).map { _ in GridItem(.flexible()) }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.movies) { movie in
                        TrendingMovieItemView(movie: movie)
                            .onAppear {
                                viewModel.didReachMovie(movie)
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Trending Movies")
            .searchable(text: $search)
        }
    }
}

#Preview {
    TrendingMoviesView<TrendingMoviesViewModel>(
        viewModel: TrendingMoviesViewModelFactory().viewModel
    )
}
