//
//  LocalStorageServiceManagerMock.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import XCTest
import RealmSwift
@testable import InstaFlixData
@testable import InstaFlixNetworking
@testable import InstaFlixDomain


final class LocalStorageServiceManagerMock: LocalStorageServiceType {
    
    var realm: Realm!
    
    init() {
        let config = Realm.Configuration(inMemoryIdentifier: "MoviesTestDB")
        self.realm = try! Realm(configuration: config)
    }
    
    func addMovie(movie: InstaFlixData.LocalMovie) {
        try? self.realm.write {
            self.realm.add(movie)
        }
    }
    
    func fetchFavoriteMovies() -> Results<LocalMovie> {
        return self.realm.objects(LocalMovie.self)
    }
}
