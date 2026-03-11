//
//  RecordsViewCell.swift
//  RacingGame
//
//  Created by Анна Швайко on 13.01.26.
//

import Foundation
import UIKit
import SnapKit

final class RecordsViewCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = MainVCLayout.numberOfLines
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.large, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = MainVCLayout.numberOfLines
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.medium, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = MainVCLayout.numberOfLines
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.extraLarge, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = MainVCLayout.numberOfLines
        label.textAlignment = .right
        label.font = .systemFont(ofSize: FontSize.small, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = AppColors.cellBackground
        
        contentView.addSubview(positionLabel)
        positionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(RecordsVCLayout.cellInset)
            make.right.equalToSuperview().inset(RecordsVCLayout.cellInset)
            make.top.equalToSuperview().offset(RecordsVCLayout.cellInset)
        }
        
        contentView.addSubview(playerNameLabel)
        playerNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(RecordsVCLayout.cellInset)
            make.top.equalTo(positionLabel.snp.bottom).offset(RecordsVCLayout.cellSmallInset)
            make.bottom.equalToSuperview().offset(-RecordsVCLayout.cellInset)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(RecordsVCLayout.cellInset)
            make.right.equalToSuperview().inset(RecordsVCLayout.cellInset)
            make.bottom.equalToSuperview().inset(RecordsVCLayout.cellInset)
        }
    }
    
    func configure(with result: RaceResult, position:Int){
        positionLabel.text = "\(position)"
        playerNameLabel.text = result.playerName
        
        let minutes = result.duration / GameVCLayout.secondsInMinute
        let seconds = result.duration % GameVCLayout.secondsInMinute
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        
        dateLabel.text = dateFormatter.string(from:result.date)
        
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.recordFormat
        formatter.locale = Locale.current
        return formatter
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [positionLabel, playerNameLabel, timeLabel, dateLabel].forEach {$0.text=nil}
    }
}


