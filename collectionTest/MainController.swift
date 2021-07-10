//
//  MainController.swift
//  collectionTest
//
//  Created by  zholon on 07/07/2021.
//

import UIKit
import Firebase
import SideMenu




class MainController: UICollectionViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let db = Firestore.firestore()
    var pizzaArray: [ModelPizza] = []
    var id: String?
   private let sideMenu = SideMenuNavigationController(rootViewController: UIViewController())

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        readCollection()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pizzaArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named:pizzaArray[indexPath.item].pizzaName)
        cell.priceLable.text = pizzaArray[indexPath.item].price + " $"
        cell.namePizza.text = pizzaArray[indexPath.item].pizzaName
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let dVC = segue.destination as! detaillController
            dVC.id = id
            
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AlertController = UIAlertController(title: "Add pizza", message: nil, preferredStyle: .actionSheet)
        let add = UIAlertAction(title: "Add", style: .default) { action in
            
        }
        AlertController.addAction(add)
        present(AlertController, animated: true, completion: nil)
    }
    
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
       present(sideMenu, animated: true)
    }
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func readCollection() {
        
        db.collection("pizza").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    print("\(doc.documentID) => \(doc.data())")
                    self.id = doc.documentID
                    
                    let data = doc.data()
                    if let price = data["price"] as? String, let name = data["name"] as? String
                    {
                        let newPizza = ModelPizza(pizzaName: name, price: price)
                        
                        
                        self.pizzaArray.append(newPizza)
                        print(self.pizzaArray)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
            
            
        }
    }

    

}

extension MainController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

