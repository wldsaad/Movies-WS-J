//
//  MovieGenresListView.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import SwiftUI
import Combine

struct MovieGenresListView: View {
    
    var genres: [Genre]
    
    var didTapGenre = PassthroughSubject<Genre, Never>()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres) { genre in
                    MovieGenresListItemView(genre: genre)
                        .onTapGesture {
                            didTapGenre.send(genre)
                        }
                }
            }
            .padding(4)
        }
    }
}

#Preview {
    MovieGenresListView(genres: [
        .init(id: 0, name: "Action", selected: false),
        .init(id: 1, name: "Thriller", selected: true),
        .init(id: 2, name: "Comedy", selected: false),
        .init(id: 3, name: "Romance", selected: false),
        .init(id: 4, name: "Fantasy", selected: false),
    ])
}
