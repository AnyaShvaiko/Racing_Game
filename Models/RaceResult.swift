//
//  RaceResult.swift
//  RacingGame
//
//  Created by Анна Швайко on 11.12.25.
//

import Foundation

final class RaceResult: Codable {
    var playerName: String
    var duration: Int
    var date: Date
    
    init(playerName: String, duration: Int, date: Date) {
        self.playerName = playerName
        self.duration = duration
        self.date = date
    }
}
