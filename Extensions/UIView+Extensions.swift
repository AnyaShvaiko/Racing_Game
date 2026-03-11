//
//  Extensions.swift
//  RacingGame
//
//  Created by Анна Швайко on 2.12.25.
//

import UIKit

extension UIView{
    
    func dropShadow(){
        layer.masksToBounds = false
        layer.shadowColor = AppColors.shadowColor.cgColor
        layer.shadowOpacity = Float(AppAttributes.shadowOpacity)
        layer.shadowOffset = CGSize(
            width: AppAttributes.shadowOffset,
            height: AppAttributes.shadowOffset
        )
        layer.shadowRadius = AppAttributes.shadowRadius
    }
    
    func addGradient(){
        let gradient = CAGradientLayer()
        gradient.colors = [
            AppColors.gradientStart,
            AppColors.gradientEnd
        ]
        gradient.startPoint = CGPoint(x: AppAttributes.gradientStartPointX, y: AppAttributes.gradientStartPointY)
        gradient.endPoint = CGPoint(x: AppAttributes.gradientEndPointX, y: AppAttributes.gradientEndPointY)
        gradient.frame = bounds
        gradient.cornerRadius = layer.cornerRadius
        
        layer.insertSublayer(gradient, at: 0)
    }
}
