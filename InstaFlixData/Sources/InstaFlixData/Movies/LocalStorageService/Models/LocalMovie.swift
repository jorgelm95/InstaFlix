//
//  LocalMovie.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import RealmSwift

public class LocalMovie: Object {
    @Persisted var id: Int
    @Persisted var adult: Bool
    @Persisted var originalTitle: String
    @Persisted var overview: String
    @Persisted var releaseDate: String
    @Persisted var originalLanguage: String
    @Persisted var voteAverage: String
    @Persisted var hasVideo: Bool
    @Persisted var posterPath: String
}
