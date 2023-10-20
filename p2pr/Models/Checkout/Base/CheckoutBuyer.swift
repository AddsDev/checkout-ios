//
//  CheckoutBuyer.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutBuyer: Codable {
    var address: CheckoutAddress
    var document: String
    var documentType: String
    var email: String
    var mobile: String
    var name: String
    var surname: String
    
    enum CodingKeys: String, CodingKey {
        case address, document, documentType, email, mobile, name, surname
    }
    
    init(buyer: Buyer) {
        self.address = CheckoutAddress(city: buyer.city, country: buyer.country, phone: buyer.phone, postalCode: buyer.postalCode, state: buyer.state, street: buyer.street)
        self.document = buyer.document
        self.documentType = buyer.documentType
        self.email = buyer.email
        self.mobile = buyer.mobile
        self.name = buyer.name
        self.surname = buyer.surname
    }
}
