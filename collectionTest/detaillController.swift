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
    var onePizzas: [ModelPizza] = []
    
    @IBOutlet weak var quantityStapper: UIStepper!
    @IBOutlet weak var quantityTF: UITextField!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        readCollection()
    
        
        readOneDoc()
        imageView.layer.cornerRadius = 30
        quantityTF.text = String(Int(quantityStapper.value))
    }
 
    
    @IBAction func addPizzaAction(_ sender: UIStepper) {
        quantityTF.text = String(Int(quantityStapper.value))
    }
    @IBAction func closeAct(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func bayAction(_ sender: UIButton) {
        AddAllert()
        writeBayToBD()
    }
    // MARK: read data from firestore
    func writeBayToBD()  {
        
        let pizzaBay = ModelForBay(client: (Auth.auth().currentUser?.email)! as String, namePizza: nameLabel.text!, price: priceLable.text!, quantity: quantityStapper.value)
        db.collection("order").document().setData([
            "name": pizzaBay.namePizza,
            "client": pizzaBay.client,
            "price": pizzaBay.price,
            "quantity": pizzaBay.quantity,
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    func readOneDoc() {
        let docRef = db.collection("pizza").document(id)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data =  document.data(){
                    if let price = data["price"] as? String,
                       let name = data["name"] as? String,
                       let id = data["id"] as? String,
                       let description = data["description"] as? String
                    {
                            let newPizza = ModelPizza(pizzaName: name, price: price, id: id, description: description)
                        
                        DispatchQueue.main.async {
                            self.onePizzas.append(newPizza)
                            self.imageView.image = UIImage(named: self.onePizzas.first!.pizzaName)
                            self.descriptionLable.text = self.onePizzas.first!.description
                            self.nameLabel.text = self.onePizzas.first!.pizzaName
                            self.priceLable.text = self.onePizzas.first!.price + " $"
                        }
                        
                        
                    }
                }
            } else {
                print("Document does not exist")
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

