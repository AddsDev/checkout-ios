//
//  CheckoutItem.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutItem: Codable {
    var category: String
    var name: String
    var price: Int
    var qty: Int
    var sku: Int
    var tax: Int
    
    enum CodingKeys: String, CodingKey {
        case category, name, price, qty, sku, tax
    }
    
    func total() -> Double { Double(price * qty) }
        
    
    init(item: Item) {
        self.category = item.category
        self.name = item.name
        self.price = item.price
        self.qty = item.qty
        self.sku = item.sku
        self.tax = item.tax
        
    }
}
