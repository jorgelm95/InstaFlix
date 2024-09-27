//
//  UITableView+Extensions.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import UIKit

extension UITableView {
    
    func setEmptyState(text: String, image: String, delegate: RetryDataDelegate) {
        let emptyState = EmptyStateView(text: text, image: image, frame: CGRect(
            x: 0,
            y: 0,
            width: self.bounds.size.width,
            height: self.bounds.size.height), delegate: delegate)
        self.backgroundView = emptyState
    }
}
