//
//  String+Extensions.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import Foundation

extension String {
    static var empty: String = ""
    
    var isNotEmpty: Bool {
        return  self != .empty
    }
    
    var localizable: String {
        NSLocalizedString(self, comment: "InstaFlix Text")
    }
}
