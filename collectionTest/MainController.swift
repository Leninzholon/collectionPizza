//
//  MainController.swift
//  collectionTest
//
//  Created by  zholon on 07/07/2021.
//

import UIKit
import Firebase
import SideMenu




class MainController: UICollectionViewController, MenuControllerDelegate {
 
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let db = Firestore.firestore()
    var pizzaArray: [ModelPizza] = []
    var id: String?
    private var sideMenu: SideMenuNavigationController?
    
    private let settingsController = roomCientViewController()
    private let infoController = aboutUsController() 

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: SideMenuItem.allCases)

        menu.delegate = self

        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true

        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)

        addChildControllers()
        readCollection()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
    }
    
    private func addChildControllers() {
        addChild(settingsController)
        addChild(infoController)

        view.addSubview(settingsController.view)
        view.addSubview(infoController.view)

        settingsController.view.frame = view.bounds
        infoController.view.frame = view.bounds

        settingsController.didMove(toParent: self)
        infoController.didMove(toParent: self)

        settingsController.view.isHidden = true
        infoController.view.isHidden = true
    }
    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)

        title = named.rawValue
        switch named {
        case .home:
            settingsController.view.isHidden = true
            infoController.view.isHidden = true

        case .info:
            settingsController.view.isHidden = true
            infoController.view.isHidden = false

        case .settings:
            settingsController.view.isHidden = false
            infoController.view.isHidden = true
        }

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

        
    @IBAction func cartAction(_ sender: UIBarButtonItem) {
      
        if let vc = storyboard?.instantiateViewController(withIdentifier: "cartBay"){
        self.navigationController?.pushViewController(vc, animated: true)
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = collectionView.indexPath(for: sender as! UICollectionViewCell) else { return }
        let id = selectedIndex.item
            if segue.identifier == "detaill"{
                let dVC = segue.destination as! detaillController
                dVC.id = String(id)

            }
            

        }
    


    @IBAction func menuAction(_ sender: UIBarButtonItem) {
      present(sideMenu!, animated: true)
        
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
        id = ""
        db.collection("pizza").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    print("\(doc.documentID) => \(doc.data())")
                   
                    
                    let data = doc.data()
                    if let price = data["price"] as? String, let name = data["name"] as? String,
                    let id = data["id"] as? String
                    {
                        let newPizza = ModelPizza(pizzaName: name, price: price, id: id)
                        
                        
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

