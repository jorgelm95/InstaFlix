//
//  MovieListPresenter.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import InstaFlixDomain

final class MovieListPresenter: MovieListPresenterType {
    
    // MARK: - Internal properties -
    var interactor: MovieListInteractorType
    var router: MovieListRouterType?
    var shouldShouwFavoriteMovie: Bool
    unowned var view: MovieListViewType
    
    // MARK: - LifeCycle -
    
    init(interactor: MovieListInteractorType,
        view: MovieListViewType,
        showFavoritesMovies: Bool) {
            
            self.interactor = interactor
            self.view = view
            self.shouldShouwFavoriteMovie = showFavoritesMovies
        }
    
    // MARK: - Internal methods -
    
    func fetchMovies() {
        if shouldShouwFavoriteMovie {
            self.interactor.fetchFavoriesMovies()
        } else {
            self.interactor.fetchMovies()
        }
    }
    
    func saveFavorite(movie: InstaFlixDomain.Movie) {
        self.interactor.saveFavorite(movie: movie)
    }
    
    
    func goToMovieDetail(_ movieDetail: InstaFlixDomain.Movie) {
        router?.goToDetailMovietModule(movieDetail)
    }
}

// MARK: - MovieIntInteractorOuputType -

extension MovieListPresenter: MovieIntInteractorOuputType {
    func showMovies(_ items: [Movie]) {
        view.removeLoadingView()
        view.movieListState = .filled
        view.items = items
    }
    
    func manageRequestError(error: FetchListMoviesError) {
        view.removeLoadingView()
        switch error {
        case .invalidResponse:
            view.movieListState = .emptyResults
        case .undefined:
            view.movieListState = .NetworkError
        }
    }
    
    func showAlert() {
        view.showInformativeAlert()
    }
}
