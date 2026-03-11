//
//  UIViewController+Extension.swift
//  RacingGame
//
//  Created by Анна Швайко on 2.12.25.
//

import UIKit

extension UIViewController{
    func showAlert(title: String, message: String, okAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(
            title: title.localized,
            message: message.localized,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: LocalizedKeys.ok.localized, style: .default){_ in
            okAction?()
        }
        
        let cancelAction = UIAlertAction(
            title: LocalizedKeys.cancel.localized, style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
