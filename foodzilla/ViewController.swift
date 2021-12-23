//
//  ViewController.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    let animation = Animation.named("SplashAnimation")
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.frame = CGRect(x:87, y:264, width: 240, height: 260)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "home", sender: nil)
        }
       
    }
        
    }




