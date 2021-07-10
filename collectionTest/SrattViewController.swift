//
//  SrattViewController.swift
//  collectionTest
//
//  Created by  zholon on 08/07/2021.
//

import UIKit

class SrattViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func registration(_ sender: UIButton) {
        performSegue(withIdentifier: "registration", sender: self)
    }
    
}
