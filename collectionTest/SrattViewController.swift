//
//  SrattViewController.swift
//  collectionTest
//
//  Created by  zholon on 08/07/2021.
//

import UIKit
import Lottie

class SrattViewController: UIViewController {
    @IBOutlet weak var animationView: AnimationView!
    
   
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        animationView.play()
    }
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. Set animation content mode
        
        animationView.contentMode = .scaleToFill
        
        // 2. Set animation loop mode
        
        animationView.loopMode = .loop
        
        // 3. Adjust animation speed
        
        animationView.animationSpeed = 1
        
        // 4. Play animation
        animationView.play()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func registration(_ sender: UIButton) {
        performSegue(withIdentifier: "registration", sender: self)
    }
    
}
