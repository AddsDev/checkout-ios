//
//  Error.swift
//  p2pr
//
//  Created by Adrian Ruiz on 9/10/23.
//

import Foundation

struct ErrorCheckout: Decodable, Result {
    var status: CheckoutStatus
}
