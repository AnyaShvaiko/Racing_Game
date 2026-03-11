//
//  Constants.swift
//  RacingGame
//
//  Created by Анна Швайко on 25.02.26.


import UIKit
import Foundation

enum ImageNames {
    static let mainCarPicture = "https://i.pinimg.com/1200x/d9/90/bf/d990bf71e2f5418b5ebc5a0cb85c8dbd.jpg"
    static let plusIcon = "PlusIcon"
    
    static let carBase = "Car"
    static let car1 = "Car1"
    static let car2 = "Car2"
    static let car3 = "Car3"
    static let road = "road"
    static let roadside = "grass"
    static let crashExplosion = "crash_explosion"
    
    static let stones = "Stones"
    static let garbage = "Garbage"
    static let tires = "Tires"
    static let tree = "tree"
    static let directionSign = "direction_sign"
    static let scoreSign = "score_sign"
    static let stopSign = "stop_sign"
    static let bush = "bush"
    static let trafficLight = "traffic_light"
    
    static let backgroundSettings = "backgroundsettings"
    static let recordsBackground = "recordsbackground"
}

enum SongNames {
    
    static let songFile = "song"
    static let songExtension = "mp3"
}

enum AppAttributes {
    
    static let appleWord = "Apple "
    static let xWord = "x "
    static let authorName = "Anna Sh."
    static let mainTitleFontName = "Futura-Bold"
    static let customColorName = "myColor"
    static let defaultPlayerName = "Player"
    
    static let shadowOpacity: Double = 1.0
    static let shadowOffset: CGFloat = 5
    static let shadowRadius: CGFloat = 10
    
    static let gradientStartPointX: CGFloat = 0
    static let gradientStartPointY: CGFloat = 0
    static let gradientEndPointX: CGFloat = 1
    static let gradientEndPointY: CGFloat = 1
}

enum LocalizedKeys {
    static let back = "<Back"
    static let cancel = "Cancel"
    static let ok = "Ok"
    
    static let racingGame = "RACING \nGAME"
    static let gameScreen = "Game Screen"
    static let tableOfRecords = "Table of Records"
    static let settings = "Settings"
    
    static let time = "TIME"
    static let speed = "SPEED"
    static let records = "RECORDS"
    static let kmh = "km/h"
    static let gameOver = "Game Over"
    static let youCrashed = "You crashed!"
    static let dontGo = "Don't Go!"
    static let progressLost = "If you exit now, your progress will be lost."
    
    static let settingsTitle = "SETTINGS"
    static let enterYourName = "Enter Your Name"
    static let imagePickerTitle = "image_picker_title"
    static let imagePickerCamera = "image_picker_camera"
    static let imagePickerLibrary = "image_picker_library"
}

enum MainVCLayout {
    static let buttonHorizontalInset: CGFloat = 32
    static let buttonTopOffset: CGFloat = 280
    static let buttonHeight: CGFloat = 50
    static let buttonSpacing: CGFloat = 24
    static let buttonCornerRadius: CGFloat = 8
    static let labelBottomOffset: CGFloat = -64
    static let labelHorizontalInset: CGFloat = 32
    static let imageViewBottomInset: CGFloat = 16
    static let imageViewTopOffset: CGFloat = 16
    static let bottomLabelOffset: CGFloat = -16
    static let numberOfLines: Int = 0
}

enum GameVCLayout {
    
    static let roadSideWidth: CGFloat = 60
    static let roadSideInset: CGFloat = 60
    
    static let carWidth: CGFloat = 72
    static let carHeight: CGFloat = 136
    static let carBottomOffset: CGFloat = 220
    
    static let moveButtonSize: CGFloat = 48
    static let moveButtonSideOffset: CGFloat = 96
    static let moveButtonBottomOffset: CGFloat = 32
    static let moveButtonCornerRadius: CGFloat = 16
    
    static let backButtonTopOffset: CGFloat = 60
    static let backButtonWidth: CGFloat = 60
    static let backButtonHeight: CGFloat = 32
    static let backButtonLeftOffset: CGFloat = 0
    static let backButtonCornerRadius: CGFloat = 6
    
    static let timerLabelWidth: CGFloat = 60
    static let timerLabelHeight: CGFloat = 24
    static let timerLabelCornerRadius: CGFloat = 8
    static let speedLabelSize: CGFloat = 60
    static let speedLabelCornerRadius: CGFloat = 30
    
    static let photoSize: CGFloat = 120
    static let photoCornerRadius: CGFloat = 60
    static let photoRightInset: CGFloat = 16
    static let photoTopOffset: CGFloat = 60
    static let nameLabelTopOffset: CGFloat = 8
    
    static let obstacleWidth: CGFloat = 80
    static let obstacleHeight: CGFloat = 120
    static let roadObstacleSize: CGFloat = 120
    static let roadSideOffset: CGFloat = 8
    static let explosionSize: CGFloat = 100
    
    static let labelSpacing: CGFloat = 16
    static let smallLabelSpacing: CGFloat = 8
    
    static let speedBorderWidth: CGFloat = 3
    
    static let initialTimerText = "00:00"
    static let initialSpeedText = "60"
    
    static let carMoveStep: CGFloat = 30
    
    static let secondsInMinute = 60
}

enum SettingsVCLayout {
    static let sideInset: CGFloat = 20
    static let smallInset: CGFloat = 10
    static let mediumInset: CGFloat = 16
    static let largeInset: CGFloat = 32
    
    static let buttonSize: CGFloat = 40
    static let buttonCornerRadius: CGFloat = 8
    static let textFieldHeight: CGFloat = 40
    static let textFieldCornerRadius: CGFloat = 12
    static let textFieldBorderWidth: CGFloat = 2
    static let speedBorderWidth: CGFloat = 3
    static let speedCircleSize: CGFloat = 70
    static let speedCircleCornerRadius: CGFloat = 35
    static let obstacleImageSize: CGFloat = 100
    
    static let labelTopOffset: CGFloat = 10
    static let elementsSpacing: CGFloat = 20
    static let smallSpacing: CGFloat = 2
    static let bottomOffset: CGFloat = -20
    
    static let profileHeightMultiplier: CGFloat = 0.25
    static let itemHeight: CGFloat = 120
    static let speedViewHeight: CGFloat = 100
}

enum RecordsVCLayout {
    static let labelTopOffset: CGFloat = 60
    static let labelWidth: CGFloat = 200
    static let tableViewTopOffset: CGFloat = 20
    static let tableViewHorizontalInset: CGFloat = 16
    static let tableViewBottomInset: CGFloat = 40
    static let backButtonLeftOffset: CGFloat = 30
    static let backButtonTopOffset: CGFloat = 60
    static let backButtonWidth: CGFloat = 60
    static let backButtonHeight: CGFloat = 32
    static let cellInset: CGFloat = 16
    static let cellSmallInset: CGFloat = 8
}

enum Animation {
    static let carMoveDuration: TimeInterval = 0.3
    static let explosionDuration: TimeInterval = 0.4
    static let explosionScale: CGFloat = 3.0
    static let numberOfLoops: Int = -1
}

enum TimerInterval {
    static let roadAnimation: TimeInterval = 0.01
    static let raceTimer: TimeInterval = 1.0
    static let moveCheck: TimeInterval = 0.02
    static let roadObstacleSpawn: TimeInterval = 4.0
    static let sideObstacleSpawn: TimeInterval = 2.0
}

enum GameSpeed {
    static let slow: CGFloat = 2
    static let normal: CGFloat = 3
    static let fast: CGFloat = 5
    
    static let slowValue = 30
    static let normalValue = 60
    static let fastValue = 90
}

enum CrashFrame {
    static let car1Car2YOffset: CGFloat = 5
    static let car3YOffset: CGFloat = 15
    static let car1Car2HeightReduce: CGFloat = 5
    static let car3HeightReduce: CGFloat = 20
    static let carWidthReduce: CGFloat = 10
    static let carSideOffset: CGFloat = 5
    
    static let stoneHeightReduce: CGFloat = 30
    static let garbageHeightReduce: CGFloat = 20
    static let tiresHeightReduce: CGFloat = 5
    static let obstacleWidthReduce: CGFloat = 10
    static let obstacleXOffset: CGFloat = 5
    
    static let sideCarWidthReduce: CGFloat = 30
    static let sideCarHeightReduce: CGFloat = 30
    static let sideCarYOffset: CGFloat = 15
    static let sideObstacleHeightReduce: CGFloat = 5
    static let sideObstacleWidthReduce: CGFloat = 10
    static let sideObstacleXOffset: CGFloat = 5
}

enum FontSize {
    static let small: CGFloat = 14
    static let medium: CGFloat = 16
    static let large: CGFloat = 20
    static let extraLarge: CGFloat = 24
    static let title: CGFloat = 32
    static let mainTitle: CGFloat = 50
    static let minimumScaleFactor: CGFloat = 0.5
}

enum FontSizeSetTitle {
    static let setTitleLeft = "←"
    static let setTitleRight = "→"
}

enum DateFormat {
    static let recordFormat = "dd MMM yyyy"
}

enum AppColors {
    static let shadowColor = UIColor.orange
    static let gradientStart = UIColor.orange.cgColor
    static let gradientEnd = UIColor.red.cgColor
    static let buttonBackground = UIColor.black.withAlphaComponent(0.4)
    static let timerBackground = UIColor.black.withAlphaComponent(0.5)
    static let backButtonBackground = UIColor.systemGray.withAlphaComponent(0.3)
    static let speedBorder = UIColor.red.cgColor
    static let speedBackground = UIColor.white
    static let speedText = UIColor.black
    static let cellBackground = UIColor.black.withAlphaComponent(0.2)
    static let selectedSpeedButton = UIColor.systemMint
    static let textFieldBackground = UIColor.systemGray6
    static let textFieldBorder = UIColor.systemMint.cgColor
    static let textFieldText = UIColor.black
    static let backButtonTitle = UIColor.systemMint
}

enum GameArrays {
    static let cars = ["Car1", "Car2", "Car3"]
    static let obstacles = ["Stones", "Garbage", "Tires"]
    static let leftObstacleImages = ["tree", "direction_sign", "score_sign"]
    static let rightObstacleImages = ["stop_sign", "bush", "traffic_light"]
    static let speedOptions = [30, 60, 90]
}
