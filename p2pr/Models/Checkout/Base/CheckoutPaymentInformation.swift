//
//  CheckoutPaymentInformation.swift
//  p2pr
//
//  Created by Adrian Ruiz on 11/10/23.
//

import Foundation

struct CheckoutPaymentInformation: Decodable {
    var status: CheckoutStatus
    var receipt: String
    var internalReference: Int64
    var paymentMethodName: String
}
