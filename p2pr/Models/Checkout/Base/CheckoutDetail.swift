//
//  CheckoutDetail.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutDetail: Codable {
    var amount: Double
    var kind: String
    
    enum CodingKeys: String, CodingKey {
        case amount, kind
    }
}
