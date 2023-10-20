//
//  CheckoutInformationResponse.swift
//  p2pr
//
//  Created by Adrian Ruiz on 10/10/23.
//

import Foundation

struct CheckoutInformationResponse: Decodable, Result {
    var status: CheckoutStatus
    var requestId: Int?
    var request: CheckoutPaymentRequest?
    var payment: [CheckoutPaymentInformation]?
}
