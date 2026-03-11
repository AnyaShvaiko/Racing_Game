//
//  RecordsViewController.swift
//  RacingGame
//
//  Created by Анна Швайко on 12.11.25.
//

import UIKit
import SnapKit
import Kingfisher

final class RecordsViewController: UIViewController{
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedKeys.back.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.small, weight: .medium)
        button.backgroundColor = AppColors.backButtonBackground
        button.layer.cornerRadius = GameVCLayout.backButtonCornerRadius
        return button
    }()
    
    private lazy var backgroungImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: ImageNames.recordsBackground)
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecordsViewCell.self, forCellReuseIdentifier: RecordsViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.alwaysBounceVertical = true
        return tableView
    }()
    
    private let recordsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = MainVCLayout.numberOfLines
        label.textAlignment = .center
        label.text = LocalizedKeys.records.localized
        label.font = .systemFont(ofSize: FontSize.extraLarge, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    
    private let saveLoadManager = SaveLoadManager()
    private var records: [RaceResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        showResults()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recordsLabel.dropShadow()
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(backgroungImage)
        backgroungImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(recordsLabel)
        recordsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(RecordsVCLayout.labelTopOffset)
            make.width.equalTo(RecordsVCLayout.labelWidth)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recordsLabel.snp.bottom).offset(RecordsVCLayout.tableViewTopOffset)
            make.left.right.equalToSuperview().inset(RecordsVCLayout.tableViewHorizontalInset)
            make.bottom.equalToSuperview().inset(RecordsVCLayout.tableViewBottomInset)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(RecordsVCLayout.backButtonLeftOffset)
            make.top.equalToSuperview().offset(RecordsVCLayout.backButtonTopOffset)
            make.width.equalTo(RecordsVCLayout.backButtonWidth)
            make.height.equalTo(RecordsVCLayout.backButtonHeight)
        }
        
        
        let backButtonAction = UIAction {_ in
            self.backButtonPressed()
        }
        backButton.addAction(backButtonAction, for:.touchUpInside)
    }
    
    private func showResults() {
        records = saveLoadManager.loadRaceResults()
        records.sort { $0.duration > $1.duration }
        tableView.reloadData()
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension RecordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordsViewCell.identifier, for: indexPath) as? RecordsViewCell else {return RecordsViewCell()}
        let record = records[indexPath.row]
        let position = indexPath.row + 1
        cell.configure(with: record, position: position)
        return cell
    }
}

