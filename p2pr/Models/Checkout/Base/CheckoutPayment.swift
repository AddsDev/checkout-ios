//
//  CheckoutPayment.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

class CheckoutPayment: Codable {
    var status: CheckoutStatus? = nil
    var buyer: CheckoutBuyer?
    var allowPartial: Bool =  false
    var amount: CheckoutAmount
    var description: String
    var items: [CheckoutItem]?
    var recurringRemove: CheckoutRecurringRemove?
    var reference: String
    var shipping: CheckoutShipping?
    var internalReference: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case status, buyer, allowPartial, amount, description, items, reference, shipping, internalReference
        case recurringRemove = "recurring_remove"
    }
    
    init(package: WelcomePackage, buyer: Buyer) {
        self.buyer = .init(buyer: buyer)
        self.items = package.items.map { item in .init(item: item)}
        self.amount = .init(package: package)
        self.description = package.detail
        self.reference = String(UInt64.random(in: 100..<1000))
        self.shipping = nil
        self.recurringRemove = nil
    }
}
