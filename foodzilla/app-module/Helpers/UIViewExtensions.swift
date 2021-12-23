//
//  UIViewExtensions.swift
//  foodzilla
//
//  Created by Ayşenur on 16.12.2021.
//

import UIKit

extension UIView{
    func addLoginGradientView(){
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red: 250, green: 255, blue: 209, alpha: 1).cgColor,
                           
                           UIColor(red: 161, green: 255, blue: 206, alpha: 1).cgColor]
        newLayer.startPoint = CGPoint(x: 0,y: 0)
        newLayer.endPoint = CGPoint(x: 1,y: 1)
        newLayer.frame = frame
        newLayer.frame = bounds
        layer.addSublayer(newLayer)
    }
    func makeCellShadow(){
        layer.backgroundColor = UIColor.white.cgColor
        
        layer.cornerRadius = 15
        layer.masksToBounds = false
        
        backgroundColor = .white
        layer.shadowColor = UIColor(red: 0.712, green: 0.788, blue: 0.858, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowOpacity = 1
        layer.shadowRadius = 15 
    }
}

