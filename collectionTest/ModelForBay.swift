//
//  ModelForBay.swift
//  collectionTest
//
//  Created by  zholon on 14/07/2021.
//

import Foundation
struct ModelForBay {
    
    var client: String
    var namePizza: String
    var price: String
    var quantity: Double
    var quantityAndPriceString: String{
        return "\(Int(quantity)) pieces X \(price) $"
        
    }
    
}
