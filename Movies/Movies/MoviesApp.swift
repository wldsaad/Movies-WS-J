//
//  MoviesApp.swift
//  Movies
//
//  Created by Waleed Saad on 04/01/2024.
//

import SwiftUI
import SwiftData

@main
struct MoviesApp: App {

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        
        _ = LocalDataContainer.shared
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TrendingMoviesView<TrendingMoviesViewModel>(
                    viewModel: TrendingMoviesViewModelFactory().viewModel()
                )
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailsView(viewModel: MovieDetailsViewModelFactory().viewModel(movieId: movie.id))
                }
            }
        }
    }
}

extension UINavigationController: UINavigationControllerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backButtonTitle = " "
    }
}
