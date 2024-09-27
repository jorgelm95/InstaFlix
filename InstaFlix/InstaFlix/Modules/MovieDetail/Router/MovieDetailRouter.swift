//
//  MovieDetailRouter.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import UIKit
import InstaFlixDomain
import InstaFlixData

final class MovieDetailRouter: MovieDetailRouterType {
    
    var viewControllerRef: UIViewController?
    
    static func buildModule(movie: Movie) -> MovieDetailViewController {
        
        let view = MovieDetailViewController()
        
        let presenter = MovieDetailPresenter(view: view)
        let router = MovieDetailRouter()
        view.presenter = presenter
        router.viewControllerRef = view
        presenter.movieDetail = movie

        return view
    }
}
