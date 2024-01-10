//
//  MoviePropertyView.swift
//  Movies
//
//  Created by Waleed Saad on 07/01/2024.
//

import SwiftUI

struct MoviePropertyViewModel {
    
    enum MoviePropertyDescriptionType {
        case plain(String)
        case hyperlink(String)
    }
    
    let title: String
    let type: MoviePropertyDescriptionType
}

struct MoviePropertyView: View {
    
    let viewModel: MoviePropertyViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            Text(#"\#(viewModel.title):"#)
                .bold()
            
            let value: String = {
                switch viewModel.type {
                case .plain(let string): string
                case .hyperlink(let hyperlink): "[\(hyperlink)](\(hyperlink))"
                }
            }()
            Text(.init(value))
            
            Spacer()
        }
        .font(.footnote)
        .lineLimit(1)
        .minimumScaleFactor(0.5)
    }
}
