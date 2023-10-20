//
//  Item.swift
//  p2pr
//
//  Created by Adrian Ruiz on 28/09/23.
//

import Foundation
import SwiftData

@Model
final class Item: Identifiable{
    var id: String
    var category: String
    var name: String
    var price: Int
    var qty: Int
    var sku: Int
    var tax: Int
    
    init(category: String, name: String, price: Int, qty: Int, sku: Int, tax: Int) {
        self.id = UUID().uuidString
        self.category = category
        self.name = name
        self.price = price
        self.qty = qty
        self.sku = sku
        self.tax = tax
    }
    
    func total() -> Double { Double(price * qty) }
}
