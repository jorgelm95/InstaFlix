//
//  MovieDetailProtocols.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import UIKit
import InstaFlixDomain

protocol MovieDetailDetailPresenterType: AnyObject {
    var view: MovieDetailViewType { get set }
    var movieDetail: Movie? { get set }
    
    func viewDidLoad()
}

protocol MovieDetailInteractorType: AnyObject {
    var repository: MoviesLocalStorageRepositoryTye { get set }
    func saveFavorite(movie: Movie)
}

protocol MovieDetailViewType: AnyObject {
    var presenter: MovieDetailPresenter? { get set }
    var movieDetail: Movie { get set }
}

protocol MovieDetailRouterType {
    var viewControllerRef: UIViewController? { get set }
}
