//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import SwiftUI

struct MovieDetailsView<ViewModel: MovieDetailsViewModelProtocol>: View {

    // MARK: - Properties
    
    @ObservedObject private var viewModel: ViewModel
    
    @State private var scrollPosition: CGFloat = .zero
    
    private var movieTitle: AttributedString {
        var attributedString = AttributedString(viewModel.movie?.title ?? "")
        attributedString.font = .headline.bold()
        return attributedString
    }
    
    private var movieReleaseDate: AttributedString {
        var attributedString = AttributedString(viewModel.movie?.releaseDate ?? "")
        attributedString.font = .footnote
        return attributedString
    }
    
    // MARK: - Init
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            switch viewModel.moviesRequestStatus {
            case .success:
                if let movie = viewModel.movie {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            headerView(poster: movie.poster)
                            movieInfoView(movie: movie)
                        }
                    }
                } else {
                    emptyDataView
                }
            case .idle, .loading:
                ProgressView()
            case .failure:
                emptyDataView
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    private var emptyDataView: some View {
        ContentUnavailableView("No data", systemImage: "film")
    }
    
    @ViewBuilder
    private func headerView(poster: String) -> some View {
        MoviePosterView(url: poster)
            .frame(height: 400)
    }
    
    @ViewBuilder
    private func movieInfoView(movie: MovieDetails) -> some View {
        VStack {
            HStack {
                movieThumbnailView(thumbnail: movie.thumbnail)
                movieHeaderView(genres: movie.genres)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 64) {
                overviewView(movie.overview)
                MoviePropertiesView(movie: movie)
            }
            
            Spacer()
        }
        .padding(4)
    }
    
    @ViewBuilder
    private func movieThumbnailView(thumbnail: String) -> some View {
        MoviePosterView(url: thumbnail)
            .frame(width: 100, height: 130)
    }
    
    @ViewBuilder
    private func movieHeaderView(genres: String) -> some View {
        VStack(alignment: .leading) {
            Text(#"\#(movieTitle) \#(movieReleaseDate)"#)
            
            Text(genres)
                .font(.subheadline)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func overviewView(_ overview: String) -> some View {
        Text(overview)
            .font(.caption)
    }
}
