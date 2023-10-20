//
//  WelcomePackage.swift
//  p2pr
//
//  Created by Adrian Ruiz on 2/10/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class WelcomePackage: Identifiable {
    var id: String
    var title: String
    var detail: String
    var items: [Item]
    var details: [Detail]
    var taxes: [Taxes]
    
    static var standardShipping = 15000.0
    
    init(title: String, detail: String, items: [Item]?, details: [Detail]?, taxes: [Taxes]?) {
        self.id = UUID().uuidString
        self.title = title
        self.detail = detail
        self.items = items ?? []
        self.details = details ?? []
        self.taxes = taxes ?? []
    }
    
    func subTotal() -> Double {
        items.reduce(0) { $0 + $1.total() }
    }
    
    func sortedItems(category: Category) -> Binding<[Item]> {
        Binding<[Item]>(
            get: {
                self.items.filter { category.name == $0.category }
                    .sorted { $0.price < $1.price }
            },
            set: { items in
                for item in items {
                    if let index = self.items.firstIndex(where: { $0.id == item.id}) {
                        self.items[index] = item
                    }
                }
            })
    }
}

enum Category: String, CaseIterable, Identifiable {
    
    case home = "Home"
    case mystery = "Mystery"
    case books = "Books"
    case electronic = "Electronic"
    case clothes = "Clothes"
    
    var id: String { self.rawValue }
    var name: String { self.rawValue }
}

extension WelcomePackage {
    static var options: [WelcomePackage] = [
        .init(
            title: "Sample purchase with multiple products", detail: "Listing of products with values from 25k to 100k for a single unit and zero tax", items: [
                Item(category: "Mystery", name: "Objeto desconocido", price: 100000, qty: 1, sku: 201, tax: 0),
                Item(category: "Home", name: "Pergamino antiguo", price: 80000, qty: 1, sku: 202, tax: 0),
                Item(category: "Mystery", name: "Gema brillante", price: 50000, qty: 1, sku: 203, tax: 0),
                Item(category: "Books", name: "Llave dorada", price: 25000, qty: 1, sku: 204, tax: 0),
                Item(category: "Mystery", name: "Reliquia antigua", price: 30000, qty: 1, sku: 205, tax: 0),
                Item(category: "Home", name: "Estatuilla enigmática", price: 75000, qty: 1, sku: 206, tax: 0),
            ],details: nil, taxes: nil
        ),
        .init(
            title: "Sample purchase with a single product", detail: "A single product with a value of 600k for a single unit and zero tax", items: [
                Item(category: "Electronic", name: "Smart Watch", price: 50000, qty: 1, sku: 101, tax: 9500),
            ],details: nil, taxes: nil
        ),
        .init(
            title: "Sample purchase with multiple products",
            detail: "Listing of products with values from 35k to 80k for a single unit and 19% tax.",
            items: [
                Item(category: "Books", name: "Libro antiguo", price: 80000, qty: 1, sku: 302, tax: 15200),
                Item(category: "Clothes", name: "Camisa desconocida", price: 35000, qty: 2, sku: 102, tax: 6650),
            ],details: nil, taxes: nil
        ),
    ]
}
