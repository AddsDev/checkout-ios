//
//  CheckoutShipping.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutShipping: Codable {
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
}
