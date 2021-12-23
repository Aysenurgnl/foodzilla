//
//  SignUpViewController.swift
//  foodzilla
//
//  Created by Ayşenur on 14.12.2021.
//

import UIKit
import FirebaseAuth
import Firebase
import TextFieldEffects

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: TextFieldEffects!
    @IBOutlet weak var lastNameTextField: TextFieldEffects!
    @IBOutlet weak var emailTextField: TextFieldEffects!
    @IBOutlet weak var passwordTextField: TextFieldEffects!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        spinner.isHidden = true

    }
   
    func setUpElements(){
        
        //hide the error label
        errorLabel.alpha = 0
        Utilities.styleFilledButton(signUpButton)
        
      
    }
    //check the fields and validate that the data is correct.If everthing is correct , this method returns nil.Otherwise , it returns the error message
    
    func validateFields()->String?{
        //check that all fields ara filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Lütfen tüm alanları doldurunuz."
        }
        
        //check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword)==false {
            //password isn't secure enough
            return "Lütfen şifrenizin en az 8 karakter , özel karakter ve bir sayı içerdiğinden emin olun."
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            //there's something wrong with the fields , show error message
           showError(error!)
            spinner.isHidden = true
        }else{
            //create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //check for errors
                if err != nil {
                    //there was an error creating the user
                    self.showError("Kullanıcı oluşturulamadı.")
                    self.spinner.isHidden = true
                }else{
                    
                    //user was created successfully , now store the first name and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName,"lastname":lastName,"uid":result!.user.uid]) { (error) in
                        if error != nil {
                            //show error message
                            self.showError("Kullanıcı bilgisini kaydetme hatası")
                        }
                    }
                    //transition to the home screen
                    self.spinner.stopAnimating()
                    self.transitionToHome()
                }
            }
            
        }
       
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome(){
        let homeTabbarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeTabbarController) as? HomeTabbarController
        view.window?.rootViewController = homeTabbarController
        view.window?.makeKeyAndVisible()
    }
  
    
}
