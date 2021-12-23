//
//  ProfileViewController.swift
//  foodzilla
//
//  Created by Ayşenur on 15.12.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    var mainProfileItems = ["Üyelik Bilgisi", "Adreslerim","Yardım ve Destek", "Uygulamayı Değerlendir", "Çıkış Yap"]
    var mainProfileImages = ["memberInfo","addressIcon","helpandsupport","appRating","signOut"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        self.profileTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            let email = user.email
            emailLabel.text = email
        }
        
    }

    func logout(){
        let alert = UIAlertController(title: "Çıkış yapmak istediğine emin misin?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Çıkış Yap" , style: UIAlertAction.Style.destructive, handler: { (action) in
            let firebaseAuth = Auth.auth()
            do {
                try! firebaseAuth.signOut()
                if let storyboard = self.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false, completion: nil)
                    
                        }
            }catch let signOutError as NSError {
                print("error",signOutError)
            }
        }))
        alert.addAction(UIAlertAction(title: "iptal", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      
    }
    
}
extension ProfileViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainProfileItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell",for: indexPath) as! ProfileTableViewCell
        let item = mainProfileImages[indexPath.row]
        cell.setCell(text: mainProfileItems[indexPath.row], image: UIImage(named: item)!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 4:
            logout()
            break
        default:
            break
        }
    }
    
}
