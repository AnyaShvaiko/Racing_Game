//
//  ViewController.swift
//  RacingGame
//
//  Created by Анна Швайко on 12.11.25.
//

import UIKit
import Kingfisher
import SnapKit
import AVFoundation

class ViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = MainVCLayout.numberOfLines
        label.font = .systemFont(ofSize: FontSize.title, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let game: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedKeys.gameScreen.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.large, weight: .medium)
        button.layer.cornerRadius = MainVCLayout.buttonCornerRadius
        return button
    }()
    
    private let records: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedKeys.tableOfRecords.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.large, weight: .medium)
        button.layer.cornerRadius = MainVCLayout.buttonCornerRadius
        return button
    }()
    
    private let settings: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedKeys.settings.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.large, weight: .medium)
        button.layer.cornerRadius = MainVCLayout.buttonCornerRadius
        return button
    }()
    
    private var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        carShown()
        playAudio()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        game.dropShadow()
        game.addGradient()
        records.dropShadow()
        records.addGradient()
        settings.dropShadow()
        settings.addGradient()
        nameLabel.dropShadow()
        label.dropShadow()
    }
    private func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(game)
        
        game.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(MainVCLayout.buttonHorizontalInset)
            make.right.equalToSuperview().inset(MainVCLayout.buttonHorizontalInset)
            make.top.equalToSuperview().offset(MainVCLayout.buttonTopOffset)
            make.height.equalTo(MainVCLayout.buttonHeight)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(MainVCLayout.labelHorizontalInset)
            make.right.equalToSuperview().inset(MainVCLayout.labelHorizontalInset)
            make.bottom.equalTo(game.snp.top).offset(MainVCLayout.labelBottomOffset)
        }
        nameLabel.font = UIFont(name: AppAttributes.mainTitleFontName, size: FontSize.mainTitle)
        nameLabel.text = LocalizedKeys.racingGame.localized
        
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(MainVCLayout.imageViewBottomInset)
            make.top.equalTo(game.snp.bottom).offset(MainVCLayout.imageViewTopOffset)
        }
        
        view.addSubview(records)
        records.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(MainVCLayout.buttonHorizontalInset)
            make.right.equalToSuperview().inset(MainVCLayout.buttonHorizontalInset)
            make.top.equalTo(game.snp.bottom).offset(MainVCLayout.buttonSpacing)
            make.height.equalTo(MainVCLayout.buttonHeight)
        }
        view.addSubview(settings)
        settings.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(MainVCLayout.buttonHorizontalInset)
            make.right.equalToSuperview().inset(MainVCLayout.buttonHorizontalInset)
            make.top.equalTo(records.snp.bottom).offset(MainVCLayout.buttonSpacing)
            make.height.equalTo(MainVCLayout.buttonHeight)
        }
        
        
        let actionForGame = UIAction { _ in
            self.gamePressed()
        }
        game.addAction(actionForGame, for: .touchUpInside)
        
        let actionForRecords = UIAction { _ in
            self.recordsPressed()
        }
        records.addAction(actionForRecords, for: .touchUpInside)
        
        let actionForSetting = UIAction { _ in
            self.settingsPressed()
        }
        settings.addAction(actionForSetting, for: .touchUpInside)
        
        view.addSubview(label)
        label.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(MainVCLayout.bottomLabelOffset)
        }
        
        let firstWord = AppAttributes.appleWord
        let secondWord = AppAttributes.xWord
        let thirdWord = AppAttributes.authorName
        
        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: FontSize.medium, weight: .medium),
        ]
        
        if let myColor = UIColor(named: AppAttributes.customColorName) {
            attributes[.foregroundColor] = myColor
        } else {
            attributes[.foregroundColor] = UIColor.systemOrange
        }
        
        let attributedString = NSMutableAttributedString(string: firstWord, attributes: attributes)
        let xString = NSAttributedString (string: secondWord, attributes: attributes)
        let finalString = NSAttributedString(string: thirdWord, attributes: attributes)
        
        attributedString.append(xString)
        attributedString.append(finalString)
        
        label.attributedText = attributedString
        
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func carShown(){
        let url = URL(string:ImageNames.mainCarPicture)
        imageView.kf.setImage(with: url)
    }
    
    private func gamePressed(){
        let controllerGame = GameViewController()
        navigationController?.pushViewController(controllerGame, animated: true)
    }
    private func recordsPressed(){
        let controllerRecords = RecordsViewController()
        navigationController?.pushViewController(controllerRecords, animated: true)
    }
    
    private func settingsPressed(){
        let controllerSettings = SettingsViewController()
        navigationController?.pushViewController(controllerSettings, animated: true)
    }
    
    private func playAudio(){
        guard let url = Bundle.main.url(forResource: SongNames.songFile, withExtension: SongNames.songExtension) else {return}
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        player = try? AVAudioPlayer(contentsOf: url) 
        player?.numberOfLoops = Animation.numberOfLoops
        player?.play()
    }
}

