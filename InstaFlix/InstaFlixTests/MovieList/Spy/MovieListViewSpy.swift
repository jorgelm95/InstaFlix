//
//  MovieListViewSpy.swift
//  InstaFlixTests
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import Foundation
@testable import InstaFlix
@testable import InstaFlixDomain

final class MovieListViewSpy: MovieListViewType {
    
    enum Invocation: Int {
        case removeLoadingView
        case showInformativeAlert
    }
    
    var presenter: MovieListPresenterType?
    var items: [Movie] = []
    var invoctations: [Invocation] = []
    
    var movieListState: MovieListState = .initialEmpty
    
    func removeLoadingView() {
        invoctations.append(.removeLoadingView)
    }
    
    func showInformativeAlert() {
        invoctations.append(.showInformativeAlert)
    }
}
