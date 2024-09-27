//
//  RealmStorageManager.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import RealmSwift

public protocol LocalStorageServiceType {
    
    func addMovie(movie: LocalMovie)
    func fetchFavoriteMovies() -> Results<LocalMovie>
}

public class RealmStorageManager: LocalStorageServiceType {
    
    let realm = try? Realm()
    
    public init() {}
    
    public func addMovie(movie: LocalMovie) {
        try? realm?.write({
            realm?.add(movie)
        })
    }
    
    public func fetchFavoriteMovies() -> Results<LocalMovie> {
        let result: Results<LocalMovie> = self.realm!.objects(LocalMovie.self)
        return result
    }
}
