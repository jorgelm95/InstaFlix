//
//  LocalizableString.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import Foundation

struct Strings {
    
    struct ListMovies {
        static var screenTitle: String { "ListMoviesTitle".localizable }
        static var addFavoriteTitle: String { "ListMovies.AddFavoriteButtonTitle".localizable }
        static var emptyStateTitle: String { "ListMovies.EmptyState.emptyTitle".localizable }
        static var emptyResultTitle: String { "ListMovies.EmptyState.emptyResultTitle".localizable }
        static var emptyStateNetworkTitle: String { "ListMovies.EmptyState.NetworkErrorTitle".localizable }
        static var addMovieSuccessTitle: String { "ListMovies.addMovieSuccessTitle".localizable }
        static var addMovieSuccessMessage: String { "ListMovies.addMovieSuccessMessage".localizable }
        static var addMovieAlertButtonTitle: String { "ListMovies.addMovieAlertButtonTitle".localizable }
    }
    
    struct MovieDetail {
        static var screenTitle: String { "MovieDetail.screenTitle".localizable }
        static var releaseDate: String { "MovieDetail.releaseDate".localizable }
        static var allowAllPublic: String { "MovieDetail.AllowForAllPiblic".localizable }
        static var notAllowAllPublic: String { "MovieDetail.NotAllowForAllPiblic".localizable }
    }
}
