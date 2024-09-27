//
//  MovieListsProtocols.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import UIKit
import InstaFlixDomain

protocol MovieListInteractorType: AnyObject {
    var presenter: MovieIntInteractorOuputType? { get set }
    var repository: MovieRepository { get set }
    func fetchMovies()
    func fetchFavoriesMovies()
    func saveFavorite(movie: Movie)
}

protocol MovieIntInteractorOuputType: AnyObject {
    func showMovies(_ items: [Movie])
    func manageRequestError(error: FetchListMoviesError)
    func showAlert()
}

protocol MovieListRouterType: AnyObject {
    var viewControllerRef: UIViewController? { get set }
    func goToDetailMovietModule(_ movieDetail: Movie)
}

protocol MovieListPresenterType: AnyObject {
    var shouldShouwFavoriteMovie: Bool { get set }
    var interactor: MovieListInteractorType { get set }
    var view: MovieListViewType { get set }
    var router: MovieListRouterType? { get set }
    
    func fetchMovies()
    func saveFavorite(movie: Movie)
    func goToMovieDetail(_ movieDetail: Movie)
}

protocol MovieListViewType: AnyObject {
    var presenter: MovieListPresenterType? { get set }
    var items: [Movie] { get set }
    var movieListState: MovieListState { get set }
    
    func removeLoadingView()
    func showInformativeAlert()
}

protocol saveFavoriteMoviewViewDelegate {
    func saveMovie(movie: Movie)
}


enum MovieListState {
    case initialEmpty
    case filled
    case emptyResults
    case NetworkError
}
