//
//  MovieGenresListItemView.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import SwiftUI

struct MovieGenresListItemView: View {
    
    let genre: Genre
        
    var body: some View {
        let selected = genre.selected
        let tintColor: Color = .accentColor
        
        let textView = Text(genre.name)
            .lineLimit(1)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background {
                selected ? tintColor : Color.clear
            }
            .font(.footnote)
            .foregroundStyle(selected ? Color.black : .primary)
        
        if selected {
            textView
                .clipShape(Capsule())
        } else {
            textView
                .overlay(Capsule().stroke(tintColor, lineWidth: 1))
        }
    }
}

#Preview {
    MovieGenresListItemView(genre: .init(id: 0, name: "Action", selected: true))
}
