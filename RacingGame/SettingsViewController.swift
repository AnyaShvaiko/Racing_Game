//
// SettingsViewController.swift
//  RacingGame
//
//  Created by Анна Швайко on 12.11.25.
//

import UIKit
import SnapKit
import Kingfisher

class SettingsViewController: UIViewController{
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = MainVCLayout.numberOfLines
        label.text = LocalizedKeys.settingsTitle.localized
        label.font = .systemFont(ofSize: FontSize.extraLarge, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: ImageNames.backgroundSettings)
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedKeys.back.localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.small, weight: .medium)
        button.setTitleColor(AppColors.backButtonTitle, for: .normal)
        button.backgroundColor = AppColors.backButtonBackground
        button.layer.cornerRadius = GameVCLayout.backButtonCornerRadius
        return button
    }()
    
    private let userNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LocalizedKeys.enterYourName.localized
        textField.backgroundColor = AppColors.textFieldBackground
        textField.textAlignment = .center
        textField.layer.borderColor = AppColors.textFieldBorder
        textField.layer.borderWidth = SettingsVCLayout.textFieldBorderWidth
        textField.layer.cornerRadius = SettingsVCLayout.textFieldCornerRadius
        textField.textColor = AppColors.textFieldText
        return textField
    }()
    
    private let userPhotoImage: UIImageView = {
        let imageView = UIImageView()
        let defaultImage = UIImage(named:ImageNames.plusIcon)
        imageView.image = defaultImage
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let carView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let carImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let obstacleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let obstacleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let speedView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let speedValueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(GameSpeed.normalValue)"
        label.textColor = AppColors.speedText
        label.font = .systemFont(ofSize: FontSize.large, weight: .bold)
        label.textAlignment = .center
        label.backgroundColor = AppColors.speedBackground
        label.layer.borderColor = AppColors.speedBorder
        label.layer.borderWidth = SettingsVCLayout.speedBorderWidth
        label.layer.cornerRadius = SettingsVCLayout.speedCircleCornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private let kmhLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedKeys.kmh.localized
        label.textColor = .white
        label.font = .systemFont(ofSize: FontSize.small, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setTitle(FontSizeSetTitle.setTitleLeft, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.large, weight: .bold)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = SettingsVCLayout.buttonCornerRadius
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setTitle(FontSizeSetTitle.setTitleRight, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.large, weight: .bold)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = SettingsVCLayout.buttonCornerRadius
        return button
    }()
    
    private let leftButtonSecond: UIButton = {
        let button = UIButton()
        button.setTitle(FontSizeSetTitle.setTitleLeft, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.large, weight: .bold)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = SettingsVCLayout.buttonCornerRadius
        return button
    }()
    
    private let rightButtonSecond: UIButton = {
        let button = UIButton()
        button.setTitle(FontSizeSetTitle.setTitleRight, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.large, weight: .bold)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = SettingsVCLayout.buttonCornerRadius
        return button
    }()
    
    private let leftButtonSpeed: UIButton = {
        let button = UIButton()
        button.setTitle(FontSizeSetTitle.setTitleLeft, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.extraLarge, weight: .bold)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = SettingsVCLayout.buttonCornerRadius
        return button
    }()
    
    private let rightButtonSpeed: UIButton = {
        let button = UIButton()
        button.setTitle(FontSizeSetTitle.setTitleRight, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.extraLarge, weight: .bold)
        button.backgroundColor = AppColors.buttonBackground
        button.layer.cornerRadius = SettingsVCLayout.buttonCornerRadius
        return button
    }()
    
    private var speedOptions = GameArrays.speedOptions
    private var currentSpeedIndex = 1
    private var selectedSpeed: Int {
        return speedOptions[currentSpeedIndex]
    }
    
    private var currentCarIndex = 0
    private var currentObstacleIndex = 0
    
    private let saveLoadManager = SaveLoadManager()
    private let settings = SaveLoadManager().loadSettings()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadUserAvatar()
        loadSettingsData()
        DispatchQueue.main.async { [weak self] in
            self?.updatePhotoCornerRadius()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userPhotoImage.layer.cornerRadius = userPhotoImage.frame.height/2
        userPhotoImage.layer.masksToBounds = true
        settingsLabel.dropShadow()
    }
    
    private func configureUI(){
        view.backgroundColor = .white
        
        userNameField.text = settings.namePlayer
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(settingsLabel)
        settingsLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(SettingsVCLayout.labelTopOffset)
            make.width.equalTo(RecordsVCLayout.labelWidth)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(SettingsVCLayout.sideInset)
            make.centerY.equalTo(settingsLabel)
            make.width.equalTo(GameVCLayout.backButtonWidth)
            make.height.equalTo(GameVCLayout.backButtonHeight)
        }
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(SettingsVCLayout.sideInset)
            make.top.equalTo(settingsLabel.snp.bottom).offset(SettingsVCLayout.elementsSpacing)
            make.height.equalTo(view.snp.height).multipliedBy(SettingsVCLayout.profileHeightMultiplier)
        }
        
        view.addSubview(speedView)
        speedView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(SettingsVCLayout.sideInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(SettingsVCLayout.bottomOffset)
            make.height.equalTo(SettingsVCLayout.speedViewHeight)
        }
        
        view.addSubview(carView)
        view.addSubview(obstacleView)
        
        carView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(SettingsVCLayout.sideInset)
            make.top.equalTo(profileView.snp.bottom).offset(SettingsVCLayout.elementsSpacing)
            make.height.equalTo(SettingsVCLayout.itemHeight)
        }
        
        obstacleView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(SettingsVCLayout.sideInset)
            make.top.equalTo(carView.snp.bottom).offset(SettingsVCLayout.elementsSpacing)
            make.bottom.equalTo(speedView.snp.top).offset(-SettingsVCLayout.elementsSpacing)
        }
        
        profileView.addSubview(userNameField)
        userNameField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-SettingsVCLayout.smallInset)
            make.height.equalTo(SettingsVCLayout.textFieldHeight)
            make.left.right.equalToSuperview().inset(SettingsVCLayout.sideInset)
        }
        
        profileView.addSubview(userPhotoImage)
        userPhotoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(SettingsVCLayout.smallInset)
            make.bottom.equalTo(userNameField.snp.top).offset(-SettingsVCLayout.smallInset)
            make.width.equalTo(userPhotoImage.snp.height)
        }
        
        carView.addSubview(carImage)
        carImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(SettingsVCLayout.smallInset)
            make.width.equalTo(carImage.snp.height)
        }
        
        carView.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(SettingsVCLayout.smallInset)
            make.width.height.equalTo(SettingsVCLayout.buttonSize)
        }
        
        carView.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(SettingsVCLayout.smallInset)
            make.width.height.equalTo(SettingsVCLayout.buttonSize)
        }
        
        obstacleView.addSubview(obstacleImage)
        obstacleImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(SettingsVCLayout.obstacleImageSize)
        }
        
        obstacleView.addSubview(rightButtonSecond)
        rightButtonSecond.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(SettingsVCLayout.smallInset)
            make.width.height.equalTo(SettingsVCLayout.buttonSize)
        }
        
        obstacleView.addSubview(leftButtonSecond)
        leftButtonSecond.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(SettingsVCLayout.smallInset)
            make.width.height.equalTo(SettingsVCLayout.buttonSize)
        }
        
        speedView.addSubview(speedValueLabel)
        speedValueLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(SettingsVCLayout.speedCircleSize)
        }
        
        speedView.addSubview(kmhLabel)
        kmhLabel.snp.makeConstraints { make in
            make.centerX.equalTo(speedValueLabel)
            make.top.equalTo(speedValueLabel.snp.bottom).offset(SettingsVCLayout.smallSpacing)
        }
        
        speedView.addSubview(rightButtonSpeed)
        rightButtonSpeed.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(SettingsVCLayout.smallInset)
            make.width.height.equalTo(SettingsVCLayout.buttonSize)
        }
        
        speedView.addSubview(leftButtonSpeed)
        leftButtonSpeed.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(SettingsVCLayout.smallInset)
            make.width.height.equalTo(SettingsVCLayout.buttonSize)
        }
        
        
        
        let backAction = UIAction { _ in
            self.backButtonPressed()
        }
        backButton.addAction(backAction, for: .touchUpInside)
        
        let leftCarAction = UIAction { _ in
            self.carLeftPressed()
        }
        leftButton.addAction(leftCarAction, for: .touchUpInside)
        
        let rightCarAction = UIAction { _ in
            self.carRightPressed()
        }
        rightButton.addAction(rightCarAction, for: .touchUpInside)
        
        let leftObstacleAction = UIAction { _ in
            self.obstacleLeftPressed()
        }
        leftButtonSecond.addAction(leftObstacleAction, for: .touchUpInside)
        
        let rightObstacleAction = UIAction { _ in
            self.obstacleRightPressed()
        }
        rightButtonSecond.addAction(rightObstacleAction, for: .touchUpInside)
        
        let leftSpeedAction = UIAction { _ in
            self.speedLeftPressed()
        }
        leftButtonSpeed.addAction(leftSpeedAction, for: .touchUpInside)
        
        let rightSpeedAction = UIAction { _ in
            self.speedRightPressed()
        }
        rightButtonSpeed.addAction(rightSpeedAction, for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        
        let tapGesturePhoto = UITapGestureRecognizer(target: self, action: #selector(chooseUserImage))
        userPhotoImage.addGestureRecognizer(tapGesturePhoto)
    }
    
    @objc private func backButtonPressed() {
        saveSettings()
        hideKeyboard()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc private func chooseUserImage(){
        showImagePickerAlert()
    }
    
    private func showImagePickerAlert(){
        let alert = UIAlertController(
            title: LocalizedKeys.imagePickerTitle.localized,
            message: nil,
            preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title:LocalizedKeys.imagePickerCamera.localized, style: .default){ [weak self] _ in
            self?.showPicker(.camera)
        }
        alert.addAction(cameraAction)
        
        let libraryAction = UIAlertAction(title: LocalizedKeys.imagePickerLibrary.localized, style: .default){ [weak self] _ in
            self?.showPicker(.photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: LocalizedKeys.cancel.localized, style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func showPicker(_ sourceType:UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    func loadUserAvatar() {
        if let imageName = saveLoadManager.loadUserImage(),
           let image = saveLoadManager.loadImage(name: imageName){
            userPhotoImage.image = image
        } else {
            
            userPhotoImage.image = UIImage(named: ImageNames.plusIcon)
        }
    }
    
    private func updatePhotoCornerRadius() {
        guard userPhotoImage.frame.height > 0 else { return }
        userPhotoImage.layer.cornerRadius = userPhotoImage.frame.height / 2
        userPhotoImage.layer.masksToBounds = true
    }
    
    private func loadSettingsData() {
        let settings = saveLoadManager.loadSettings()
        
        userNameField.text = settings.namePlayer
        
        if let carIndex = GameArrays.cars.firstIndex(of: settings.carName) {
            currentCarIndex = carIndex
        }
        
        if let obstacleIndex = GameArrays.obstacles.firstIndex(of: settings.obstacleName) {
            currentObstacleIndex = obstacleIndex
        }
        
        if let speedIndex = GameArrays.speedOptions.firstIndex(of: settings.speed) {
            currentSpeedIndex = speedIndex
            speedValueLabel.text = "\(settings.speed)"
        }
        
        updateCarImage()
        updateObstacleImage()
    }
    
    private func updateCarImage() {
        carImage.image = UIImage(named: GameArrays.cars[currentCarIndex])
    }
    
    private func updateObstacleImage() {
        obstacleImage.image = UIImage(named: GameArrays.obstacles[currentObstacleIndex])
    }
    
    @objc private func carLeftPressed() {
        currentCarIndex = (currentCarIndex - 1 + GameArrays.cars.count) % GameArrays.cars.count
        updateCarImage()
    }
    
    @objc private func carRightPressed() {
        currentCarIndex = (currentCarIndex + 1) % GameArrays.cars.count
        updateCarImage()
    }
    
    @objc private func obstacleLeftPressed() {
        currentObstacleIndex = (currentObstacleIndex - 1 + GameArrays.obstacles.count) % GameArrays.obstacles.count
        updateObstacleImage()
    }
    
    @objc private func obstacleRightPressed() {
        currentObstacleIndex = (currentObstacleIndex + 1) % GameArrays.obstacles.count
        updateObstacleImage()
    }
    
    @objc private func speedLeftPressed() {
        currentSpeedIndex = (currentSpeedIndex - 1 + GameArrays.speedOptions.count) % GameArrays.speedOptions.count
        speedValueLabel.text = "\(GameArrays.speedOptions[currentSpeedIndex])"
    }
    
    @objc private func speedRightPressed() {
        currentSpeedIndex = (currentSpeedIndex + 1) % GameArrays.speedOptions.count
        speedValueLabel.text = "\(GameArrays.speedOptions[currentSpeedIndex])"
    }
    
    private func saveSettings() {
        let newSettings = GameSettings(
            namePlayer: userNameField.text ?? AppAttributes.defaultPlayerName,
            carName: GameArrays.cars[currentCarIndex],
            obstacleName: GameArrays.obstacles[currentObstacleIndex],
            speed: GameArrays.speedOptions[currentSpeedIndex]
        )
        
        saveLoadManager.saveSettings(newSettings)
    }
}


extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :Any]){
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.userPhotoImage.image = image
        if let imageName = saveLoadManager.saveImage(image: image){
            saveLoadManager.saveUserImage(imageName)
            UserDefaults.standard.synchronize()
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        picker.dismiss(animated: true)
    }
}


































