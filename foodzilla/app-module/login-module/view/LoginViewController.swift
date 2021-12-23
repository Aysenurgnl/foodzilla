//
//  LoginViewController.swift
//  foodzilla
//
//  Created by Ayşenur on 14.12.2021.
//

import UIKit
import FirebaseAuth
import TextFieldEffects

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: TextFieldEffects!
    @IBOutlet weak var passwordTextField: TextFieldEffects!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        setUpElements()
        
    }
    func setUpElements(){
        //hide the error label
        errorLabel.alpha = 0
        Utilities.styleFilledButton(loginButton)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        //Validate textfields
        //create
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }else{
                self.spinner.stopAnimating()
                let homeTabbarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeTabbarController) as? HomeTabbarController
                self.view.window?.rootViewController = homeTabbarController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
  
}

