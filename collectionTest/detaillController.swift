//
//  detaillController.swift
//  collectionTest
//
//  Created by  zholon on 07/07/2021.
//

import UIKit
import Firebase

class detaillController: UIViewController {
    let db = Firestore.firestore()
    var id: String!
    var onePizza: ModelPizza? = nil
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        readCollection()
        print("!!!!!!\(onePizza)")
        guard let onePizza = onePizza else {
            return
        }
        imageView.image = UIImage(named: onePizza.pizzaName)
        
        
    }
    
    
    @IBAction func closeAct(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func bayAction(_ sender: UIButton) {
        AddAllert()
    }
    func readCollection() {
        
        db.collection("pizza").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    print("\(doc.documentID) => \(doc.data())")
                    
                    
                    
                    let data = doc.data()
                    if let id = self.id{
                        if id == doc.documentID{
                            if let price = data["price"] as? String, let name = data["name"] as? String
                            {
                                let newPizza = ModelPizza(pizzaName: name, price: price)
                                
                                
                                self.onePizza = newPizza
                            }
                        }
                    }
                }
            }
            
            
        }
    }
    
}
extension detaillController{
    func AddAllert(){
        let ac = UIAlertController(title: "Pizza add in cart", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default) { action in
            self.dismiss(animated: true)
        }
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
    
}
