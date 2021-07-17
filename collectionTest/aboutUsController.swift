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
        label.text = "phone: 0664566774"
        label.font = UIFont(name: "Avenir-Light", size: 24)
        label.textColor = #colorLiteral(red: 0.1468463242, green: 0.2587963939, blue: 0.27839306, alpha: 1)
        return label
    }()
    private lazy var phoneContainerView: UIView = {
        let view = UIView()
    
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "phone.bubble.left.fill")
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor( left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        view.addSubview(contactsLebel)
        contactsLebel.anchor( left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
       return view
    }()
    
    private let emailLebel: UILabel = {
        let label = UILabel()
        label.text = "email: 1@2.com"
        label.font = UIFont(name: "Avenir-Light", size: 24)
        label.textColor = #colorLiteral(red: 0.1468463242, green: 0.2587963939, blue: 0.27839306, alpha: 1)
            return label
    }()
    private lazy var emailContainerView: UIView = {
        let view = UIView()
    
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "envelope")
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor( left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        view.addSubview(emailLebel)
        emailLebel.anchor( left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
       return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9441747069, green: 0.5805539489, blue: 0.2003090978, alpha: 1)
        view.addSubview(titleLebel)
//        view.addSubview(contactsLebel)
      
        titleLebel.anchor(top:view.safeAreaLayoutGuide.topAnchor)
        titleLebel.centerX(inView: view)

        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: titleLebel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 16, paddingRight: 16, width: 16, height: 50)
//        view.addSubview(phoneContainerView)
//        phoneContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, width: 16, height: 50)


       
    }
    


}
