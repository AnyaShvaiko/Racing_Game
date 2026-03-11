//
//  GameSettings.swift
//  RacingGame
//
//  Created by Анна Швайко on 11.12.25.
//

final class GameSettings: Codable {
    
    var namePlayer: String
    var carName: String
    var obstacleName: String
    var speed: Int
    
    init(namePlayer: String, carName: String, obstacleName: String, speed: Int = 60) {
        self.namePlayer = namePlayer
        self.carName = carName
        self.obstacleName = obstacleName
        self.speed = speed
    }
    
    private enum CodingKeys: String, CodingKey {
        case namePlayer, carName, obstacleName, speed
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(namePlayer, forKey: .namePlayer)
        try container.encode(carName, forKey: .carName)
        try container.encode(obstacleName, forKey: .obstacleName)
        try container.encode(speed, forKey: .speed)
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        namePlayer = try container.decode(String.self, forKey: .namePlayer)
        carName = try container.decode(String.self, forKey: .carName)
        obstacleName = try container.decode(String.self, forKey: .obstacleName)
        speed = try container.decode(Int.self, forKey: .speed)
    }

}
