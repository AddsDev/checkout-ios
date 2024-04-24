//
//  CheckoutStatus.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutStatus: Codable {
    var status: String? = nil
    var reason: String
    var message: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case status, reason, message, date
    }
}
