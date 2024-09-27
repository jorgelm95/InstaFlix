//
//  UINavigationController+Extensions.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import UIKit

extension UINavigationController {
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationBar.tintColor = .white
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
