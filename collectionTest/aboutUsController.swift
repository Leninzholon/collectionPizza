//
//  aboutUsController.swift
//  collectionTest
//
//  Created by  zholon on 10/07/2021.
//

import UIKit

class aboutUsController: UIViewController {

    @IBOutlet var viewVC: UIView!
    @IBOutlet weak var buttonStart: UIButton!
    private let titleLebel: UILabel = {
        let label = UILabel()
        label.text = "Contacts"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = #colorLiteral(red: 0.1468463242, green: 0.2587963939, blue: 0.27839306, alpha: 1)
        return label
    }()
    private let contactsLebel: UILabel = {
        let label = UILabel()
        label.text = "phone number: 0664566774"
        label.font = UIFont(name: "Avenir-Light", size: 21)
        label.textColor = #colorLiteral(red: 0.1468463242, green: 0.2587963939, blue: 0.27839306, alpha: 1)
        return label
    }()
    private let emailLebel: UILabel = {
        let label = UILabel()
        label.text = "email: 1@2.com"
        label.font = UIFont(name: "Avenir-Light", size: 21)
        label.textColor = #colorLiteral(red: 0.1468463242, green: 0.2587963939, blue: 0.27839306, alpha: 1)
            return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9441747069, green: 0.5805539489, blue: 0.2003090978, alpha: 1)
        view.addSubview(titleLebel)
        view.addSubview(contactsLebel)
        view.addSubview(emailLebel)
        titleLebel.anchor(top:view.safeAreaLayoutGuide.topAnchor)
        titleLebel.centerX(inView: view)
        contactsLebel.anchor(top: titleLebel.topAnchor, paddingTop: 80)
        contactsLebel.centerX(inView: view)
        emailLebel.anchor(top: contactsLebel.topAnchor, paddingTop: 50)
        emailLebel.centerX(inView: view)
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
