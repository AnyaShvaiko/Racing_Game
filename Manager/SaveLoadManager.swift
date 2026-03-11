//
//  SaveLoadManager.swift
//  RacingGame
//
//  Created by Анна Швайко on 8.12.25.
//

import Foundation
import UIKit

enum Keys: String {
    case settings
    case userNameImage
    case raceResults
}

final class SaveLoadManager {
    
    private let defaults = UserDefaults.standard
    
    func saveSettings(_ setting: GameSettings){
        defaults.set(encodable: setting, forKey: Keys.settings.rawValue)
    }
    
    func loadSettings() -> GameSettings {
        defaults.get(decodableType: GameSettings.self, forKey: Keys.settings.rawValue) ?? GameSettings(     namePlayer: AppAttributes.defaultPlayerName,carName: GameArrays.cars[0],obstacleName:GameArrays.obstacles[0],speed: GameSpeed.normalValue)
    }
    
    
    func saveImage(image: UIImage) -> String?{
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileName = UUID().uuidString
        let fileURL = directory.appendingPathComponent(fileName)
        
        guard let data = image.pngData() else {return nil}
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            print("error")
            return nil
        }
    }
    
    func loadImage(name: String) -> UIImage? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = directory.appendingPathComponent(name)
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func saveUserImage(_ text: String){
        defaults.set(text , forKey: Keys.userNameImage.rawValue)
    }
    
    func loadUserImage() -> String? {
        return defaults.object(forKey: Keys.userNameImage.rawValue) as? String
    }
    
    func saveRaceResult(_ result: RaceResult) {
            var results = loadRaceResults()
            results.append(result)
            if let data = try? JSONEncoder().encode(results) {
                defaults.set(data, forKey: Keys.raceResults.rawValue)
            }
        }

        func loadRaceResults() -> [RaceResult] {
            guard let data = defaults.data(forKey: Keys.raceResults.rawValue),
                  let results = try? JSONDecoder().decode([RaceResult].self, from: data) else { return [] }
            return results
        }
    }
















