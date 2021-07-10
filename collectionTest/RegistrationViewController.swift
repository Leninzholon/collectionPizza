//
//  RegistrationViewController.swift
//  collectionTest
//
//  Created by  zholon on 08/07/2021.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.isHidden = true
    }
    


    @IBAction func registration(_ sender: UIButton) {
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                    self.errorLabel.isHidden = false
                    
                } else {
                    self.performSegue(withIdentifier: "registration", sender: self)
                }
            }
        }
        
    }
    
}
