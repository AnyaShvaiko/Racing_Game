//
//  GameViewController.swift
//  RacingGame
//
//  Created by Анна Швайко on 12.11.25.
//

import UIKit
import SnapKit

class GameViewController: UIViewController{
    
    private let firstRoadView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: ImageNames.road)
        return imageView
    }()
    
    private let secondRoadView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: ImageNames.road)
        return imageView
    }()
    
    private let roadContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let roadObstacleView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let leftRoadsideView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: ImageNames.roadside)
        return imageView
    }()
    
    private let rightRoadsideView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: ImageNames.roadside)
        return imageView
    }()
    
    private let carView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: ImageNames.carBase)
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedKeys.back.localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.small, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = AppColors.backButtonBackground
        button.layer.cornerRadius =  GameVCLayout.backButtonCornerRadius
        return button
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setTitle(FontSizeSetTitle.setTitleLeft, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.title, weight: .bold)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = GameVCLayout.moveButtonCornerRadius
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setTitle(FontSizeSetTitle.setTitleRight, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.title, weight: .bold)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = GameVCLayout.moveButtonCornerRadius
        return button
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = GameVCLayout.initialTimerText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: FontSize.large, weight: .bold)
        label.textColor = .white
        label.backgroundColor = AppColors.timerBackground
        label.layer.cornerRadius = GameVCLayout.timerLabelCornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private let timerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedKeys.time.localized
        label.textAlignment = .center
        label.font = .systemFont(ofSize: FontSize.medium, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private let speedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedKeys.speed.localized
        label.textAlignment = .center
        label.font = .systemFont(ofSize: FontSize.medium, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = FontSize.minimumScaleFactor
        return label
    }()
    
    private let speedValueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(GameSpeed.normalValue)"
        label.textColor = AppColors.speedText
        label.font = .systemFont(ofSize: FontSize.large, weight: .bold)
        label.textAlignment = .center
        label.backgroundColor = AppColors.speedBackground
        label.layer.borderColor = AppColors.speedBorder
        label.layer.borderWidth = GameVCLayout.speedBorderWidth
        label.layer.cornerRadius = GameVCLayout.speedLabelCornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private let userPhotoImage: UIImageView = {
        let imageView = UIImageView()
        let defaultImage = UIImage(named:ImageNames.plusIcon)
        imageView.image = defaultImage
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: FontSize.large, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private var leftObstacles: [UIImageView] = []
    private var rightObstacles: [UIImageView] = []
    private var roadObstacles: [UIImageView] = []
    let leftObstacleImages = GameArrays.leftObstacleImages
    let rightObstacleImages = GameArrays.rightObstacleImages
    
    private var roadTimer: Timer?
    private var raceTimer: Timer?
    private var raceDuration: Int = 0
    private var isCrashed = false
    
    private var roadObstacleMoveTimer: Timer?
    private var roadObstacleAppearTimer: Timer?
    private var sideCrashCheckTimer: Timer?
    private var sideObstacleAppearTimer: Timer?
    
    private let settings = SaveLoadManager().loadSettings()
    private var moveSpeed: CGFloat = GameSpeed.normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch settings.speed {
        case 30:
            moveSpeed = GameSpeed.slow
            speedValueLabel.text = "\(GameSpeed.slowValue)"
        case 60:
            moveSpeed = GameSpeed.normal
            speedValueLabel.text = "\(GameSpeed.normalValue)"
        case 90:
            moveSpeed = GameSpeed.fast
            speedValueLabel.text = "\(GameSpeed.fastValue)"
        default:
            moveSpeed = GameSpeed.normal
            speedValueLabel.text = "\(GameSpeed.normalValue)"
        }
        
        configureUI()
        loadUserAvatar()
        startRoadAnimation()
        startRaceTimer()
        startRoadObstacleTimer()
        startSideObstacleTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        roadTimer?.invalidate()
        raceTimer?.invalidate()
        sideObstacleAppearTimer?.invalidate()
    }
    private func configureUI(){
        view.backgroundColor = .white
        
        if let carImage = UIImage(named: settings.carName) {
            self.carView.image = carImage
        }
        
        
        view.addSubview(roadContainerView)
        roadContainerView.frame = view.bounds
        
        roadContainerView.addSubview(firstRoadView)
        roadContainerView.addSubview(secondRoadView)
        
        
        firstRoadView.frame = CGRect(
            x: GameVCLayout.roadSideInset,
            y: 0,
            width: roadContainerView.frame.width - GameVCLayout.roadSideInset * 2,
            height: roadContainerView.frame.height
        )
        secondRoadView.frame = CGRect(
            x: GameVCLayout.roadSideInset,
            y: -roadContainerView.frame.height,
            width: roadContainerView.frame.width - GameVCLayout.roadSideInset * 2,
            height: roadContainerView.frame.height
        )
        
        roadContainerView.addSubview(leftRoadsideView)
        roadContainerView.addSubview(rightRoadsideView)
        leftRoadsideView.frame = CGRect(
            x: 0,
            y: 0,
            width: GameVCLayout.roadSideWidth,
            height: roadContainerView.frame.height
        )
        rightRoadsideView.frame = CGRect(
            x: roadContainerView.frame.width - GameVCLayout.roadSideWidth,
            y: 0,
            width: GameVCLayout.roadSideWidth,
            height: roadContainerView.frame.height
        )
        
        roadContainerView.addSubview(carView)
        carView.frame = CGRect(
            x: roadContainerView.frame.width / 2 - GameVCLayout.carWidth / 2,
            y: roadContainerView.frame.height - GameVCLayout.carBottomOffset,
            width: GameVCLayout.carWidth,
            height: GameVCLayout.carHeight
        )
        
        view.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(GameVCLayout.moveButtonSideOffset)
            make.bottom.equalToSuperview().inset(GameVCLayout.moveButtonBottomOffset)
            make.width.height.equalTo(GameVCLayout.moveButtonSize)
        }
        
        view.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(GameVCLayout.moveButtonSideOffset)
            make.bottom.equalToSuperview().inset(GameVCLayout.moveButtonBottomOffset)
            make.width.height.equalTo(GameVCLayout.moveButtonSize)
        }
        
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(GameVCLayout.backButtonLeftOffset)
            make.top.equalToSuperview().offset(GameVCLayout.backButtonTopOffset)
            make.width.equalTo(GameVCLayout.backButtonWidth)
            make.height.equalTo(GameVCLayout.backButtonHeight)
        }
        
        view.addSubview(timerTitleLabel)
        timerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(GameVCLayout.labelSpacing)
            make.centerX.equalTo(backButton.snp.centerX)
        }
        
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(timerTitleLabel.snp.bottom).offset(GameVCLayout.labelSpacing)
            make.centerX.equalTo(timerTitleLabel.snp.centerX)
            make.width.equalTo(GameVCLayout.timerLabelWidth)
            make.height.equalTo(GameVCLayout.timerLabelHeight)
        }
        
        view.addSubview(speedTitleLabel)
        speedTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(GameVCLayout.labelSpacing)
            make.centerX.equalTo(timerTitleLabel.snp.centerX)
            make.width.lessThanOrEqualTo(GameVCLayout.speedLabelSize)
        }
        
        view.addSubview(speedValueLabel)
        speedValueLabel.snp.makeConstraints { make in
            make.top.equalTo(speedTitleLabel.snp.bottom).offset(GameVCLayout.smallLabelSpacing)
            make.centerX.equalTo(speedTitleLabel.snp.centerX)
            make.width.height.equalTo(GameVCLayout.speedLabelSize)
        }
        
        view.addSubview(userPhotoImage)
        userPhotoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GameVCLayout.photoTopOffset)
            make.right.equalToSuperview().inset(GameVCLayout.photoRightInset)
            make.width.height.equalTo(GameVCLayout.photoSize)
        }
        
        userPhotoImage.layer.cornerRadius = GameVCLayout.photoCornerRadius
        userPhotoImage.clipsToBounds = true
        
        view.addSubview(playerNameLabel)
        playerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userPhotoImage.snp.bottom).offset(GameVCLayout.nameLabelTopOffset)
            make.centerX.equalTo(userPhotoImage.snp.centerX)
        }
        playerNameLabel.text = settings.namePlayer
        
        let backAction = UIAction { _ in
            self.backButtonPressed()
        }
        backButton.addAction(backAction, for: .touchUpInside)
        
        let leftAction = UIAction { _ in
            self.moveCarLeft()
        }
        leftButton.addAction(leftAction, for: .touchUpInside)
        
        let rightAction = UIAction { _ in
            self.moveCarRight()
        }
        rightButton.addAction(rightAction, for: .touchUpInside)
    }
    
    private func loadUserAvatar() {
        let saveLoadManager = SaveLoadManager()
        if let imageName = saveLoadManager.loadUserImage(),
           let image = saveLoadManager.loadImage(name: imageName) {
            userPhotoImage.image = image
        } else {
            userPhotoImage.image = UIImage(named: ImageNames.plusIcon)
        }
    }
    
    private func startRoadAnimation(){
        roadTimer = Timer.scheduledTimer(withTimeInterval: TimerInterval.roadAnimation, repeats: true)
        {[weak self]_ in
            self?.moveRoad()
        }
    }
    
    private func moveRoad() {
        firstRoadView.frame.origin.y += moveSpeed
        secondRoadView.frame.origin.y += moveSpeed
        
        if firstRoadView.frame.origin.y >= roadContainerView.frame.height {
            firstRoadView.frame.origin.y = secondRoadView.frame.origin.y - roadContainerView.frame.height
        }
        
        if secondRoadView.frame.origin.y >= roadContainerView.frame.height {
            secondRoadView.frame.origin.y = firstRoadView.frame.origin.y - roadContainerView.frame.height
        }
    }
    
    private func startRaceTimer() {
        raceDuration = 0
        timerLabel.text = GameVCLayout.initialTimerText
        
        raceTimer = Timer.scheduledTimer(withTimeInterval: TimerInterval.raceTimer, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.raceDuration += 1
            self.updateTimerLabel()
        }
    }
    
    private func updateTimerLabel() {
        let minutes = raceDuration / GameVCLayout.secondsInMinute
        let seconds = raceDuration % GameVCLayout.secondsInMinute
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func stopRaceTimer() {
        raceTimer?.invalidate()
        raceTimer = nil
    }
    
    
    @objc private func moveCarLeft() {
        let step: CGFloat = GameVCLayout.carMoveStep
        var newX = carView.center.x - step
        let minX = 0 + carView.frame.width / 2
        if newX < minX { newX = minX }
        
        UIView.animate(withDuration: Animation.carMoveDuration) {
            self.carView.center.x = newX
        }
    }
    
    @objc private func moveCarRight() {
        let step: CGFloat = GameVCLayout.carMoveStep
        var newX = carView.center.x + step
        let maxX = self.roadContainerView.frame.width - carView.frame.width / 2
        if newX > maxX { newX = maxX }
        
        UIView.animate(withDuration: Animation.carMoveDuration) {
            self.carView.center.x = newX
        }
    }
    
    private func appearSideObstacle() {
        guard !isCrashed else { return }
        
        let obstacleWidth = GameVCLayout.obstacleWidth
        let obstacleHeight = GameVCLayout.obstacleHeight
        
        let isLeft = Bool.random()
        
        if isLeft, let randomLeftName = leftObstacleImages.randomElement() {
            let obstacle = UIImageView(image: UIImage(named: randomLeftName))
            obstacle.contentMode = .scaleAspectFit
            
            let obstacleX = leftRoadsideView.frame.minX + (leftRoadsideView.frame.width - obstacleWidth)/2
            let startY = -obstacleHeight - CGFloat.random(in: 0...100)
            
            obstacle.frame = CGRect(
                x: obstacleX,
                y: startY,
                width: obstacleWidth,
                height: obstacleHeight
            )
            
            roadContainerView.addSubview(obstacle)
            leftObstacles.append(obstacle)
            
        } else if !isLeft, let randomRightName = rightObstacleImages.randomElement() {
            let obstacle = UIImageView(image: UIImage(named: randomRightName))
            obstacle.contentMode = .scaleAspectFit
            
            let obstacleX = rightRoadsideView.frame.minX + (rightRoadsideView.frame.width - obstacleWidth)/2
            let startY = -obstacleHeight - CGFloat.random(in: 0...100)
            
            obstacle.frame = CGRect(
                x: obstacleX,
                y: startY,
                width: obstacleWidth,
                height: obstacleHeight
            )
            
            roadContainerView.addSubview(obstacle)
            rightObstacles.append(obstacle)
        }
    }
    
    private func appearRoadObstacle() {
        guard !isCrashed else { return }
        
        let obstacle = UIImageView(image: UIImage(named: settings.obstacleName))
        obstacle.contentMode = .scaleAspectFit
        
        let size = GameVCLayout.roadObstacleSize
        
        let roadLeftX = GameVCLayout.roadSideInset
        let roadRightX = roadContainerView.frame.width - GameVCLayout.roadSideInset
        
        let minX = roadLeftX + GameVCLayout.roadSideOffset
        let maxX = roadRightX - size - GameVCLayout.roadSideOffset
        
        obstacle.frame = CGRect(
            x: CGFloat.random(in: minX...maxX),
            y: -size,
            width: size,
            height: size
        )
        
        roadContainerView.addSubview(obstacle)
        roadObstacles.append(obstacle)
    }
    
    private func moveRoadObstaclesAndCheckCrash() {
        for obstacle in roadObstacles {
            obstacle.frame.origin.y += moveSpeed
            
            let carFrame = carView.frame
            
            let isCar1 = carView.image == UIImage(named: ImageNames.car1)
            let isCar2 = carView.image == UIImage(named: ImageNames.car2)
            
            let carNewFrame: CGRect
            if isCar1 || isCar2 {
                carNewFrame = CGRect(
                    x: carFrame.origin.x + CrashFrame.carSideOffset,
                    y: carFrame.origin.y + CrashFrame.car1Car2YOffset,
                    width: carFrame.width - CrashFrame.carWidthReduce,
                    height: carFrame.height - CrashFrame.car1Car2HeightReduce
                )
            } else {
                carNewFrame = CGRect(
                    x: carFrame.origin.x + CrashFrame.carSideOffset,
                    y: carFrame.origin.y + CrashFrame.car3YOffset,
                    width: carFrame.width - CrashFrame.carWidthReduce,
                    height: carFrame.height - CrashFrame.car3HeightReduce
                )
            }
            
            let obstacleFrame = obstacle.frame
            let isStone = obstacle.image == UIImage(named: ImageNames.stones)
            let isGarbage = obstacle.image == UIImage(named: ImageNames.garbage)
            
            let obstacleNewFrame: CGRect
            if isStone {
                obstacleNewFrame = CGRect(
                    x: obstacleFrame.origin.x + CrashFrame.obstacleXOffset,
                    y: obstacleFrame.origin.y,
                    width: obstacleFrame.width - CrashFrame.obstacleWidthReduce,
                    height: obstacleFrame.height - CrashFrame.stoneHeightReduce
                )
            } else if isGarbage {
                obstacleNewFrame = CGRect(
                    x: obstacleFrame.origin.x + CrashFrame.obstacleXOffset,
                    y: obstacleFrame.origin.y,
                    width: obstacleFrame.width - CrashFrame.obstacleWidthReduce,
                    height: obstacleFrame.height - CrashFrame.garbageHeightReduce
                )
            } else {
                obstacleNewFrame = CGRect(
                    x: obstacleFrame.origin.x + CrashFrame.obstacleXOffset,
                    y: obstacleFrame.origin.y,
                    width: obstacleFrame.width - CrashFrame.obstacleWidthReduce,
                    height: obstacleFrame.height - CrashFrame.tiresHeightReduce
                )
            }
            
            if carNewFrame.intersects(obstacleNewFrame) {
                handleCrash(with: obstacle)
                return
            }
        }
        
        roadObstacles.removeAll {
            if $0.frame.origin.y > view.frame.height {
                $0.removeFromSuperview()
                return true
            }
            return false
        }
    }
    
    private func moveSideObstaclesAndCheckCrash() {
        guard !isCrashed else { return }
        
        for obstacle in leftObstacles {
            obstacle.frame.origin.y += moveSpeed
            
            let carFrame = carView.frame
            let carNewFrame = CGRect(
                x: carFrame.origin.x + CrashFrame.sideCarYOffset,
                y: carFrame.origin.y + CrashFrame.sideCarYOffset,
                width: carFrame.width - CrashFrame.sideCarWidthReduce,
                height: carFrame.height - CrashFrame.sideCarHeightReduce
            )
            
            let obstacleFrame = obstacle.frame
            let obstacleNewFrame = CGRect(
                x: obstacleFrame.origin.x + CrashFrame.sideObstacleXOffset,
                y: obstacleFrame.origin.y,
                width: obstacleFrame.width - CrashFrame.sideObstacleWidthReduce,
                height: obstacleFrame.height - CrashFrame.sideObstacleHeightReduce
            )
            
            if carNewFrame.intersects(obstacleNewFrame) {
                handleCrash(with: obstacle)
                return
            }
        }
        
        for obstacle in rightObstacles {
            obstacle.frame.origin.y += moveSpeed
            
            let carFrame = carView.frame
            let carNewFrame = CGRect(
                x: carFrame.origin.x + CrashFrame.sideCarYOffset,
                y: carFrame.origin.y + CrashFrame.sideCarYOffset,
                width: carFrame.width - CrashFrame.sideCarWidthReduce,
                height: carFrame.height - CrashFrame.sideCarHeightReduce
            )
            
            let obstacleFrame = obstacle.frame
            let obstacleNewFrame = CGRect(
                x: obstacleFrame.origin.x + CrashFrame.sideObstacleXOffset,
                y: obstacleFrame.origin.y,
                width: obstacleFrame.width - CrashFrame.sideObstacleWidthReduce,
                height: obstacleFrame.height - CrashFrame.sideObstacleHeightReduce
            )
            
            if carNewFrame.intersects(obstacleNewFrame) {
                handleCrash(with: obstacle)
                return
            }
        }
        
        leftObstacles.removeAll {
            if $0.frame.origin.y > view.frame.height {
                $0.removeFromSuperview()
                return true
            }
            return false
        }
        
        rightObstacles.removeAll {
            if $0.frame.origin.y > view.frame.height {
                $0.removeFromSuperview()
                return true
            }
            return false
        }
    }
    
    private func startRoadObstacleTimer() {
        roadObstacleMoveTimer = Timer.scheduledTimer(withTimeInterval: TimerInterval.moveCheck, repeats: true) { [weak self] _ in
            self?.moveRoadObstaclesAndCheckCrash()
        }
        
        roadObstacleAppearTimer = Timer.scheduledTimer(withTimeInterval: TimerInterval.roadObstacleSpawn, repeats: true) { [weak self] _ in
            self?.appearRoadObstacle()
        }
    }
    
    private func startSideObstacleTimer() {
        sideCrashCheckTimer = Timer.scheduledTimer(
            withTimeInterval: TimerInterval.moveCheck,
            repeats: true
        ) { [weak self] _ in
            self?.moveSideObstaclesAndCheckCrash()
        }
        
        sideObstacleAppearTimer = Timer.scheduledTimer(
            withTimeInterval: TimerInterval.sideObstacleSpawn,
            repeats: true
        ) { [weak self] _ in
            self?.appearSideObstacle()
        }
    }
    
    private func handleCrash(with obstacle: UIImageView) {
        
        guard !isCrashed else { return }
        isCrashed = true
        
        roadTimer?.invalidate()
        raceTimer?.invalidate()
        roadObstacleMoveTimer?.invalidate()
        roadObstacleAppearTimer?.invalidate()
        sideCrashCheckTimer?.invalidate()
        sideObstacleAppearTimer?.invalidate()
        
        let explosionSize = GameVCLayout.explosionSize
        let crashExplosion = UIImageView(image: UIImage(named: ImageNames.crashExplosion))
        crashExplosion.contentMode = .scaleAspectFit
        
        crashExplosion.frame = CGRect(
            x: obstacle.frame.midX - explosionSize / 2,
            y: obstacle.frame.midY - explosionSize / 2,
            width: explosionSize,
            height: explosionSize
        )
        
        roadContainerView.addSubview(crashExplosion)
        
        UIView.animate(withDuration: Animation.explosionDuration, animations: {
            crashExplosion.transform = CGAffineTransform(scaleX: Animation.explosionScale,y: Animation.explosionScale)
            crashExplosion.alpha = 0
        }) { _ in
            crashExplosion.removeFromSuperview()
        }
        
        showAlert(title: LocalizedKeys.gameOver, message: LocalizedKeys.youCrashed) {
            self.finishRace()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private  func backButtonPressed() {
        let title = LocalizedKeys.dontGo.localized
        let message = LocalizedKeys.progressLost.localized
        
        showAlert(title: title, message: message) {
            self.finishRace()
        }
    }
    
    private func finishRace() {
        stopRaceTimer()
        
        let result = RaceResult(
            playerName: settings.namePlayer,
            duration: raceDuration,
            date: Date()
        )
        
        SaveLoadManager().saveRaceResult(result)
        navigationController?.popToRootViewController(animated: true)
    }
}




