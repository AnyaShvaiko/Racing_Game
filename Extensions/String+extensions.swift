//
//  String+extensions.swift
//  RacingGame
//
//  Created by Анна Швайко on 23.02.26.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
