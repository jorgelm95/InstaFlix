//
//  MovieListRouter.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import UIKit
import InstaFlixNetworking
import InstaFlixDomain
import InstaFlixData


final class MovieListRouter: MovieListRouterType {
    
    weak var viewControllerRef: UIViewController?
    
    static func buildModule(isFavoritesMovies: Bool = false) -> MovieListViewController {
        
        let repository: MovieRepository = FetchMoviesRepository(
            serviceManager: ServiceManager(),
            adapater: MoviesMapperAdapater(),
            localStorageManager: RealmStorageManager())
        
        let interactor = MovieListInteractor(repository: repository)
        let view = MovieListViewController()
        let presenter = MovieListPresenter(
            interactor: interactor,
            view: view, showFavoritesMovies: isFavoritesMovies)
        let router = MovieListRouter()
        view.presenter = presenter
        router.viewControllerRef = view
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func goToDetailMovietModule(_ movieDetail: InstaFlixDomain.Movie) {
        guard let navigationController = viewControllerRef?.navigationController else { return }
        let viewController = MovieDetailRouter.buildModule(movie: movieDetail)
        navigationController.pushViewController(viewController, animated: true)
    }
}
