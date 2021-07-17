//
//  CartViewController.swift
//  collectionTest
//
//  Created by  zholon on 14/07/2021.
//

import UIKit
import Firebase

class CartViewController: UITableViewController {
    @IBOutlet weak var clearButton: UIBarButtonItem!
    let db = Firestore.firestore()
    var orderPizza: [ModelForBay] = []
    var reOrderPizza: [ModelForBay] = []
    var indexes: [String] = []
    
    var idArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOrderPizza()
     
     
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderPizza.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBay", for: indexPath)
        
        
        cell.textLabel?.text = orderPizza[indexPath.row].namePizza
        cell.detailTextLabel?.text = orderPizza[indexPath.row].quantityAndPriceString
        
        
        
        return cell
    }
   
    func sortForCurrentUser() {
        let newArray = orderPizza
        orderPizza = []
        guard let user = Auth.auth().currentUser!.email else { return }
        for element in newArray{
            if user == element.client {
                orderPizza.append(element)
            }
        }
        
    }
    func createSwitch () -> UISwitch{
        
        
        let switchControl = UISwitch(frame:CGRect(x: 10, y: 65, width: 0, height: 0));
        switchControl.isOn = true
        switchControl.setOn(true, animated: false);
        switchControl.addTarget(self, action: Selector(("switchValueDidChange:")), for: .valueChanged);
        return switchControl
    }
    
    func switchValueDidChange(sender:UISwitch!){
        
        print("Switch Value : \(sender.isOn))")
    }
    func loadOrderPizza() {
        
        db.collection("order").addSnapshotListener { (querySnapshot, err) in
            if let snapshot = querySnapshot?.documents {
                for document in snapshot {
                    let data = document.data()
                    let user =  data["client"] as! String
                    if Auth.auth().currentUser!.email == user{
                        let newElement = document.documentID
                        self.idArray.append(newElement)
                    }
                }
            }
            self.orderPizza = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let name = data["name"] as? String, let price = data["price"] as? String,
                           let quantity = data["quantity"] as? Double,
                           let user = data["client"] as? String
                        {
                            let newPizza = ModelForBay(client: user, namePizza: name, price: price, quantity: quantity)
                            
                            
                            self.orderPizza.append(newPizza)
                            self.sortForCurrentUser()
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                    
                }
                
                
            }
        }
        
        
    }
    
    @IBAction func clearCart(_ sender: UIBarButtonItem) {
       
        db.collection("order").addSnapshotListener { (querySnapshot, err) in
            if let snapshot = querySnapshot?.documents {
                for document in snapshot {
                    let data = document.data()
                    let user =  data["client"] as! String
                    if Auth.auth().currentUser!.email == user{
                        let newElement = document.documentID
                        self.indexes.append(newElement)
                    }
                }
            }
            for index in self.indexes{
                self.db.collection("order").document(index).delete() { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document successfully removed!")
                            }
                        }
            }
                    }
                }
                
            

        
        
    
    @IBAction func orderAction(_ sender: UIButton) {
        AlertController()
    }
}
extension CartViewController{
    func AlertController() {
        let ac = UIAlertController(title: "Method for Pay", message: "choice credit-cart or cash", preferredStyle: .alert)
//        ac.view.addSubview(createSwitch())
        let creditAction = UIAlertAction(title: "credit-cart", style: .default) { action in
            
        }
        let cashAction = UIAlertAction(title: "cash", style: .default) { action in
            if self.orderPizza.count > 0{
                
             if let vc = self.storyboard?.instantiateViewController(withIdentifier: "cash"){
            self.navigationController?.pushViewController(vc, animated: true)
             }
            }
        }
        ac.addAction(creditAction)
        ac.addAction(cashAction)
        present(ac, animated: true, completion: nil)
        
    }
}


