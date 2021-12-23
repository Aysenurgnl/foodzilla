//
//  PasswordTextField.swift
//  foodzilla
//
//  Created by Ayşenur on 16.12.2021.
//

import Foundation
import UIKit

class PasswordTextField: UITextField {

    let rightButton  = UIButton(type: .custom)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        rightButton.setImage(UIImage(named: "password_show") , for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -26, bottom: 0, right: 0)
        rightButton.frame = CGRect(x: CGFloat(self.frame.size.width-25), y: CGFloat(20), width: CGFloat(25), height: CGFloat(25))
        rightButton.addTarget(self, action: #selector(self.toggleShowHide), for: .touchUpInside)
        self.rightView = rightButton
        self.rightViewMode = .always
    }

    @objc
    func toggleShowHide(button: UIButton) {
        toggle()
    }

    func toggle() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            rightButton.setImage(UIImage(named: "password_show") , for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "password_hide") , for: .normal)
        }
    }

}
