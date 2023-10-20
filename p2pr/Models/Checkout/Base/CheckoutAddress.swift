//
//  CheckoutAddress.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutAddress: Codable {
    var city: String
    var country: String?
    var phone: String
    var postalCode: String
    var state: String
    var street: String
    
    enum CodingKeys: String, CodingKey {
        case city, country, phone, postalCode, state, street
    }
}
