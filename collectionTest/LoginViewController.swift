//
//  LoginViewController.swift
//  collectionTest
//
//  Created by  zholon on 08/07/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLable: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLable.isHidden = true
       
    }
    

    @IBAction func loginAction(_ sender: UIButton) {
        if let email = emailTF.text,
           let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    self?.errorLable.isHidden = false
                    self!.errorLable.text = e.localizedDescription
                } else {
                    self!.performSegue(withIdentifier: "login", sender: self)
                }
            }
        }
    }
    

}
