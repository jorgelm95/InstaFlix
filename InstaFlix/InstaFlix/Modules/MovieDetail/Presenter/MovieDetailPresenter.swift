//
//  MovieDetailPresenter.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import Foundation
import InstaFlixDomain

final class MovieDetailPresenter: MovieDetailDetailPresenterType {
    
    unowned var view: MovieDetailViewType
    var movieDetail: Movie?
    
    init(view: MovieDetailViewType) {
        self.view = view
    }
    
    func viewDidLoad() {
        guard let movieDetail else { return }
        view.movieDetail = movieDetail
    }
}
