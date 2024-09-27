//
//  HomeViewController.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import UIKit

final class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {

        let firstVC = MovieListRouter.buildModule()
        firstVC.tabBarItem =  UITabBarItem(
            title: "Movies",
            image: UIImage(systemName: "movieclapper"),
            selectedImage: nil)
        
        let secondVC = MovieListRouter.buildModule(isFavoritesMovies: true)
        secondVC.tabBarItem =  UITabBarItem(
            title: "Favorires",
            image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        let tabBarList = [firstVC, secondVC]
        self.viewControllers = tabBarList.map {
            let navController = UINavigationController(rootViewController: $0)
            return navController
        }
    }
}
