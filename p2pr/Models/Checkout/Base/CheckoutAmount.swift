//
//  CheckoutAmount.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutAmount: Codable {
    var currency: String?
    var details: [CheckoutDetail]?
    var taxes: [CheckoutTaxes]?
    var total: Double?
    
    enum CodingKeys: String, CodingKey {
        case currency, details, taxes, total
    }
    
    init(package: WelcomePackage) {
        self.currency = "COP"
        self.details = [
            CheckoutDetail(amount: WelcomePackage.standardShipping, kind: "shipping"),
            CheckoutDetail(amount: package.subTotal(), kind: "subtotal")
        ]
        self.taxes = [CheckoutTaxes(amount: 0.0, kind: "tax_shipping")]
        self.total = details?.reduce(0) { $0 + $1.amount } ?? 0
    }
    
}
