//
//  RegistrationViewController.swift
//  collectionTest
//
//  Created by  zholon on 08/07/2021.
//

import UIKit
import Firebase
import Lottie

class RegistrationViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.isHidden = true
        // 1. Set animation content mode
        
        animationView.contentMode = .scaleToFill
        
        // 2. Set animation loop mode
        
        animationView.loopMode = .loop
        
        // 3. Adjust animation speed
        
        animationView.animationSpeed = 1
        
        // 4. Play animation
        animationView.play()
    }
    


    @IBAction func registration(_ sender: UIButton) {
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                    self.animationView.isHidden = true
                    self.errorLabel.isHidden = false
                    
                } else {
                    self.performSegue(withIdentifier: "registration", sender: self)
                }
            }
        }
        
    }
    
}
