//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import SwiftUI

struct MovieDetailsView<ViewModel: MovieDetailsViewModelProtocol>: View {
        
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
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if let movie = viewModel.movie {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    MoviePosterView(url: movie.poster)
                        .frame(height: 400)
                    
                    VStack {
                        HStack {
                            MoviePosterView(url: movie.thumbnail)
                                .frame(width: 100, height: 130)
                            
                            VStack(alignment: .leading) {
                                Text(#"\#(movieTitle) \#(movieReleaseDate)"#)
                                
                                Text(movie.genres)
                                    .font(.subheadline)
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 64) {
                            Text(movie.overview)
                                .font(.caption)
                            
                            MoviePropertiesView(movie: movie)
                        }
                        
                        Spacer()
                    }
                    .padding(4)
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
        } else {
            ContentUnavailableView("No data", systemImage: "film")
        }
    }
}
