//
//  MovieListRouterSpy.swift
//  InstaFlixTests
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import UIKit
@testable import InstaFlix
@testable import InstaFlixDomain

final class MovieListRouterSpy: MovieListRouterType {
    var viewControllerRef: UIViewController?
    enum Invocation: Int {
       case goToDetailMovie
   }
   
   var invocations: [Invocation] = []
   
    func goToDetailMovietModule(_ movieDetail: InstaFlixDomain.Movie) {
        invocations.append(.goToDetailMovie)
    }
}
